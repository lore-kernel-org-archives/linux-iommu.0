From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/7] Intel IOMMU scalability improvements
Date: Tue, 5 Apr 2016 11:22:49 +0200
Message-ID: <20160405092249.GE17838@8bytes.org>
References: <20151228161421.GA27829@cs.technion.ac.il>
	<CAN+hb0Xt21CMmM7uE0rzjf5p9w-W+5y8at4v1J8+pYd8tamLpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAN+hb0Xt21CMmM7uE0rzjf5p9w-W+5y8at4v1J8+pYd8tamLpQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Benjamin Serebrin <serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Dan Tsafrir <dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 15, 2016 at 11:00:34AM -0700, Benjamin Serebrin via iommu wrote:
> There are nice.=A0 Thanks very much for doing this work!
> =

> We have some preliminary results, looking at scaling to high core counts.=
=A0 We
> tested the patches on a 2-socket high core count SNB-EP server with a Bro=
adcomm
> NIC.=A0 Our benchmark uses 200 threads of TCP_RR.=A0 We see similar perfo=
rmance for
> IOMMU disabled as we do for IOMMU enabled with this patchset, which is go=
od
> news.=A0 We're working on getting a lab setup with Haswell servers so we =
can
> further test the scalability of the code.
> =

> We owe the scaling results and of course actual code reviews.

This sounds very promising. Could you guys rebase the patches to a
recent upstream kernel and repost together with your performance
results? I'd really like to see that merged.


	Joerg
