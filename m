From: "'joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org'" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 0/6] Auxiliary IOMMU domains and Arm SMMUv3
Date: Fri, 7 Dec 2018 11:29:26 +0100
Message-ID: <20181207102926.GM16835@8bytes.org>
References: <20181019181158.2395-1-jean-philippe.brucker@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19BE0E176@SHSMSX101.ccr.corp.intel.com>
	<11f88122-afd3-a34c-3cd4-db681bf5498b@arm.com>
	<20181106162539.4gmkvg57mja3bn7k@8bytes.org>
	<e22e3631-2ecb-664d-5666-8e0f865dec83@linux.intel.com>
	<20181107164323.GA19831@8bytes.org>
	<758bb120-5bc0-1e2d-ccd0-9be0bcc5d8bc@linux.intel.com>
	<20181123112125.GF1586@8bytes.org>
	<AADFC41AFE54684AB9EE6CBC0274A5D19BE68777@SHSMSX101.ccr.corp.intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19BE689B8@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19BE689B8-0J0gbvR4kThpB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On Mon, Nov 26, 2018 at 07:29:45AM +0000, Tian, Kevin wrote:
> btw Baolu just reminded me one thing which is worthy of noting here.
> 'primary' vs. 'aux' concept makes sense only when we look from a device
> p.o.v. That binding relationship is not (*should not be*) carry-and-forwarded
> cross devices. every domain must be explicitly attached to other devices
> (instead of implicitly attached being above example), and new primary/aux
> attribute on another device will be decided at attach time.

Okay, so after all the discussions we had I learned a few more things
about the scalable mode feature and thought a bit longer about how to
best support it in the IOMMU-API.

The concept of sub-domains I initially proposed certainly makes no
sense, but scalable-mode specific attach/detach functions do. So instead
of a sub-domain mode, I'd like to propose device-feature sets.

The posted patch-set already includes this as device-attributes, but I
don't like this naming as we are really talking about additional
feature sets of a device. So how about we introduce this:

	enum iommu_dev_features {
		/* ... */
		IOMMU_DEV_FEAT_AUX,
		IOMMU_DEV_FEAT_SVA,
		/* ... */
	};

	/* Check if a device supports a given feature of the IOMMU-API */
	bool iommu_dev_has_feature(struct device *dev, enum iommu_dev_features *feat);

	/*
	 * Only works if iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX)
	 * returns true
	 *
	 * Also, as long as domains are attached to a device through
	 * this interface, any trys to call iommu_attach_device() should
	 * fail (iommu_detach_device() can't fail, so we fail on the
	 * tryint to re-attach). This should make us safe against a
	 * device being attached to a guest as a whole while there are
	 * still pasid users on it (aux and sva).
	 */
	int iommu_aux_attach_device(struct iommu_domain *domain,
				    struct device *dev);

	int iommu_aux_detach_device(struct iommu_domain *domain,
				    struct device *dev);
	/*
	 * I know we are targeting a system-wide pasid-space, so that
	 * the pasid would be the same for one domain on all devices,
	 * let's just keep the option open to have different
	 * pasid-spaces in one system. Also this way we can use it to
	 * check whether the domain is attached to this device at all.
	 *
	 * returns pasid or <0 if domain has no pasid on that device.
	 */
	int iommu_aux_get_pasid(struct iommu_domain *domain,
				struct device *dev);

	/* So we need a iommu_aux_detach_all()? */

This concept can also be easily extended for supporting SVA in parallel
on the same device, with the same constraints regarding the behavior of
iommu_attach_device()/iommu_detach_device().

So what do you think about that approach?

Regards,

	Joerg

	
