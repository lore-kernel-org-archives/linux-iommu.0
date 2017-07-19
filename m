From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/5] iommu: Add capability IOMMU_CAP_BYPASS
Date: Wed, 19 Jul 2017 12:30:17 +0100
Message-ID: <20170719113017.GH13642@arm.com>
References: <1500456838-18405-1-git-send-email-anup.patel@broadcom.com>
	<1500456838-18405-2-git-send-email-anup.patel@broadcom.com>
	<675744d3-b070-1245-6ebc-579c4b5f4a75@arm.com>
	<CAALAos_o25mtphxcVE0rr9dE8YAm-os2C_HD9oDnt41ZMDP8pA@mail.gmail.com>
	<20170719112315.GE13642@arm.com>
	<CAALAos8nf-d5i74J7-sAJb2o9eFj2PVDeLLVd=wun+gW1ihXSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAALAos8nf-d5i74J7-sAJb2o9eFj2PVDeLLVd=wun+gW1ihXSA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, BCM Kernel Feedback <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 19, 2017 at 04:56:38PM +0530, Anup Patel wrote:
> On Wed, Jul 19, 2017 at 4:53 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> > On Wed, Jul 19, 2017 at 04:49:00PM +0530, Anup Patel wrote:
> >> On Wed, Jul 19, 2017 at 4:28 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> >> > On 19/07/17 10:33, Anup Patel wrote:
> >> >> Some of the IOMMUs (such as ARM SMMU) are capable of bypassing
> >> >> transactions for which no IOMMU domain is configured.
> >> >>
> >> >> This patch adds IOMMU_CAP_BYPASS which can be used by IOMMU
> >> >> drivers to advertise transation bypass capability of an IOMMU.
> >> >
> >> > Whatever the intended semantics of this are, I can't help thinking it
> >> > would be better served by allowing callers to explicitly allocate their
> >> > own IOMMU_DOMAIN_IDENTITY domains. That would also be useful for the
> >> > problem we have with legacy virtio devices behind real IOMMUs.
> >>
> >> We want to use VFIO no-IOMMU mode for FlexRM device but
> >> currently it does not allow on our SOC because IOMMU ops are
> >> registered for platform bus.
> >
> > Why do you want to use no-IOMMU mode if you have an IOMMU, and why you do
> > think the individual IOMMU drivers are the place to implement this?
> >
> > NAK to the SMMU patches, for the reasons outlined by Robin.
> 
> We have limited number of SMRs on our SOC.
> 
> There are lot of devices for which we can potentially
> configure SMMU but then due to limited number of
> SMRs so we use SMMU only for certain devices.
> 
> For FlexRM device on our SOC, we don't intend to
> use SMMU hence we need VFIO no-IOMMU mode
> working for FlexRM device on our SOC.
> 
> Please re-consider your NAK.

I'm afraid it still stands for the current implementation. If you can't
solve the SMR restriction by grouping things appropriately (which would be
my strong preference), then I think you'll have to follow-up on Robin's
suggestion of implementing support for IDENTITY domains in VFIO for no-IOMMU
mode to be used even when an IOMMU is present.

Will
