From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC 0/3] How to pass IOMMU map attr via DMA API?
Date: Thu, 20 Jun 2013 13:00:48 +0200
Message-ID: <20130620.140048.660909250426165627.hdoyu@nvidia.com>
References: <20130620093152.GE2842@mudshark.cambridge.arm.com><20130620.125929.2250094502232662356.hdoyu@nvidia.com><20130620101110.GB18536@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130620101110.GB18536-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Cc: "Will.Deacon-5wv7dgnIgG8@public.gmane.org" <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org> wrote @ Thu, 20 Jun 2013 12:11:10 +0200:

> On Thu, Jun 20, 2013 at 10:59:29AM +0100, Hiroshi Doyu wrote:
> > Hi Will,
> > 
> > Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote @ Thu, 20 Jun 2013 11:31:52 +0200:
> > 
> > > > Hiroshi Doyu (3):
> > > >   common: DMA-mapping: add DMA_ATTR_READ_ONLY attribute
> > > >   ARM: dma-mapping: Pass DMA attrs as IOMMU prot
> > > >   iommu/tegra: smmu: Support read-only mapping
> > > 
> > > These patches don't seem to have made it to the linux-arm-kernel list
> > > (either in my inbox or the list archive). Could you try and resend them please?
> > 
> > I'm sorry but linux-arm-kernel list someitmes requires me moderators
> > approval. I don't know why. I'll find a way to work around.
> 
> I guess it doesn't like the threading. It works better if you have
> "[PATCH" in the subject.

It seems to work. I did with "[PATCH" and --no-thread. Thanks.
