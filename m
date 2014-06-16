From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH v6 04/20] iommu/arm-smmu: add capability
	IOMMU_CAP_INTR_REMAP
Date: Mon, 16 Jun 2014 16:53:44 +0200
Message-ID: <20140616145344.GD18986@8bytes.org>
References: <1401987808-23596-1-git-send-email-a.motakis@virtualopensystems.com>
	<1401987808-23596-5-git-send-email-a.motakis@virtualopensystems.com>
	<20140608103129.GC3279@lvm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140608103129.GC3279@lvm>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoffer Dall <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, "moderated list:ARM SMMU DRIVER" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sun, Jun 08, 2014 at 12:31:29PM +0200, Christoffer Dall wrote:
> On Thu, Jun 05, 2014 at 07:03:12PM +0200, Antonios Motakis wrote:
> > With an ARM SMMU, interrupt remapping should always be safe from the
> > SMMU's point of view, as it is properly handled by the GIC.
> > 
> > Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> > ---
> >  drivers/iommu/arm-smmu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 15ab2af..ff29402 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -1544,7 +1544,7 @@ static int arm_smmu_domain_has_cap(struct iommu_domain *domain,
> >  	if (smmu_domain->root_cfg.smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
> >  		caps |= IOMMU_CAP_CACHE_COHERENCY;
> >  
> > -	caps |= IOMMU_CAP_NOEXEC;
> > +	caps |= IOMMU_CAP_NOEXEC | IOMMU_CAP_INTR_REMAP;
> >  
> >  	return !!(cap & caps);
> >  }
> > -- 
> > 1.8.3.2
> > 
> What does IOMMU_CAP_INTR_REMAP signify exactly?  Is there docs/examples
> somewhere I can look at?  (A quick scan of the Linux souce code doesn't
> reveal much, and I'm not sure if this is purely MSI related or what...)

The flag was introduced for x86 IOMMUs to detect whether an IOMMU in the
system has and enables interrupt remapping to allow safe device
assignment to KVM guests. Without interrupt remapping a malicious guest
could attack the host with MSIs from the attached device.

How are PCI MSIs implemented on ARM with SMMU and GIC enabled. MSIs are
only memory dma transactions in the end, is it guaranteed on ARM that a
device only sends MSI transactions it is allowed to?


	Joerg
