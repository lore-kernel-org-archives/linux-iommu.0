From: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v11 17/27] iommu/exynos: remove calls to Runtime PM API
	functions
Date: Wed, 19 Mar 2014 19:51:21 +0100
Message-ID: <5329E729.4020201@gmail.com>
References: <20140314140843.ba055f28dd7ed59c46088029@samsung.com>
	<5322FD14.5090602@samsung.com>
	<20140318185605.0380c8dfe6559c06183092e5@samsung.com>
	<532861BE.7020601@samsung.com>
	<20140319100304.5e26fa43ccdfc29178b058e1@samsung.com>
	<532997D7.6090608@samsung.com>
	<CANEJEGuYz28dGT+264CYtG+Tk6htOq=u-t4PWMtsij32X0vJFA@mail.gmail.com>
	<5329D426.9020706@samsung.com>
	<CANEJEGtCdMmWXwpoky8USLOBw7jAt1bRw8or-mDK7twxAzhWpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CANEJEGtCdMmWXwpoky8USLOBw7jAt1bRw8or-mDK7twxAzhWpA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Linux DeviceTree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 19.03.2014 19:37, Grant Grundler wrote:
> On Wed, Mar 19, 2014 at 10:30 AM, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> ...
>> As I said, AFAIK the trend is to get rid of ordering by initcalls and make
>> sure that drivers can handle missing dependencies properly, even for
>> "services" such as DMA, GPIO, clocks and so on, which after all are provided
>> by normal drivers like other.
>
> Ok - I'm not following the general kernel dev trends. initcall()
> levels are easy to understand and implement. So I would not be in a
> hurry to replace them.
>

Well, initcall level is still a way to satisfy most of dependencies, 
i.e. all client devices with higher initcall levels will probe 
successfully. However the other case needs to be handled as well - in 
this case the IOMMU binding code needs to defer probe of client driver 
if respective IOMMU is not yet available.

>>> ps. I've written IOMMU support for four different IOMMUs on three
>>> operating systems (See drivers/parisc for two linux examples). But I
>>> still feel like I at best have 80% understanding of how this one is
>>> organized/works. Abstract descriptions and convoluted code have been
>>> handicapping me (and lack of time to dig further).
>>
>>
>> Well, this is one of my concerns with this driver. It isn't easy to read
>> (and so review, maintain, extend and debug found issues).
>
> My postscript comment was more to explain why I'm not confident in my
> opinion - not a reason to reject the patch series.  I still consider
> the whole series as a step forward. But I'm not the expert here.

I fully agree with you. Other than the issues mentioned in review, the 
patches are definitely a step forward. I'd even say that all the patches 
that have nothing to do with device tree could be merged in their 
current form and the code refined later. It doesn't mean that patches 
shouldn't be reviewed now and issues spotted reported, even if they 
could be fixed later - this is for the IOMMU subsystem maintainer to decide.

As for patches related to DT support, more care needs to be taken, as 
bindings should be designed with stability in mind, so the refining 
process should happen at review stage.

> Right now, with ~30 patches posted by the exynos iommu (official?)
> maintainer, no one else who has a clue will attempt to fix or clean up
> those kinds of problems.  i.e. it's useful to enable others to fix
> what are essentially unspecified "design pattern" issues.

Agreed.

Best regards,
Tomasz
