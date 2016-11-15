From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v7 00/16] ACPI IORT ARM SMMU support
Date: Tue, 15 Nov 2016 14:07:51 +0000
Message-ID: <20161115140751.GA16710@red-moon>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
	<CAJZ5v0j09fsp4Y66v2UANOGnW4FNO7PWxpZY=Pgw=bUccEL_eA@mail.gmail.com>
	<20161115101257.GB16261@red-moon>
	<CAJZ5v0gh9qB41zcnvnETDA-5ho577uhxE4rehZqEXorFViY__w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gh9qB41zcnvnETDA-5ho577uhxE4rehZqEXorFViY__w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "open list:AMD IOMMU (AMD-VI)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Dennis Chen <dennis.chen-5wv7dgnIgG8@public.gmane.org>, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Prem Mallappa <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 15, 2016 at 02:04:09PM +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 15, 2016 at 11:12 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org> wrote:
> > Hi Rafael,
> >
> > On Thu, Nov 10, 2016 at 12:36:12AM +0100, Rafael J. Wysocki wrote:
> >> Hi Lorenzo,
> >>
> >> On Wed, Nov 9, 2016 at 3:19 PM, Lorenzo Pieralisi
> >> <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org> wrote:
> >> > This patch series is v7 of a previous posting:
> >> >
> >> > https://lkml.org/lkml/2016/10/18/506
> >>
> >> I don't see anything objectionable in this series.
> >>
> >> Please let me know which patches in particular to look at in detail.
> >
> > Are patches 7 and consequently 16 (that builds on top of 7) ok with
> > you ? They should be equivalent to nop on anything other than ARM64
> > but they touch ACPI core so they require an ACK if they are ok please.
> 
> Yes, they are.  Please feel free to add my ACKs to those or I will
> send them separately later today.

Thank you very much, I will add them to v8 that should be final,
I will send it when the dust has settled on patch 4, which looks
like the last bit to sort out (we may not even need a v8 at all).

Thanks !
Lorenzo
