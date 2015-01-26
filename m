From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v5 11/18] iommu: exynos: remove useless device_add/remove
	callbacks
Date: Mon, 26 Jan 2015 13:06:07 +0100
Message-ID: <54C62DAF.6020809@samsung.com>
References: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com>
	<1422028288-891-12-git-send-email-m.szyprowski@samsung.com>
	<2829552.kzfCU5HyxQ@avalon> <20150126110059.GC30345@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20150126110059.GC30345-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Seung-Woo Kim <sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, David Wodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2015-01-26 12:00, Joerg Roedel wrote:
> Hi Laurent,
>
> On Sun, Jan 25, 2015 at 05:38:22PM +0200, Laurent Pinchart wrote:
>> IOMMU groups still seem a bit unclear to me. Will Deacon has nicely explained
>> what they represent in
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/310816.html.
>> The IOMMU core doesn't make groups
>> mandatory, but requires them in some code paths.
>>
>> For example the coldplug device add function add_iommu_group() called for all
>> devices already registered when bus_set_iommu() is called will try to warn of
>> devices added multiple times with a WARN_ON(dev->iommu_group). Another example
>> is the iommu_bus_notifier() function which will call the remove_device()
>> operation only when dev->iommu_group isn't NULL.
>>
>> I'm thus unsure whether groups should be made mandatory, or whether the IOMMU
>> core should be fixed to make them really optional (or, third option, whether
>> there's something I haven't understood properly).
> My plan is to make IOMMU groups mandatory. I am currently preparing and
> RFC patch-set to introduce default-domains (which will be per group). So
> when all IOMMU drivers are converted to make use of default domains the
> iommu groups will be mandatory.

Thanks for the comment, I will implement all that will be needed for it 
to exynos
iommu driver, but I would like to ask if you plan to merge my existing 
patches for
exynos iommu driver to your tree?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
