From: "'joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org'" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 0/6] Auxiliary IOMMU domains and Arm SMMUv3
Date: Mon, 10 Dec 2018 09:57:46 +0100
Message-ID: <20181210085745.GN16835@8bytes.org>
References: <11f88122-afd3-a34c-3cd4-db681bf5498b@arm.com>
	<20181106162539.4gmkvg57mja3bn7k@8bytes.org>
	<e22e3631-2ecb-664d-5666-8e0f865dec83@linux.intel.com>
	<20181107164323.GA19831@8bytes.org>
	<758bb120-5bc0-1e2d-ccd0-9be0bcc5d8bc@linux.intel.com>
	<20181123112125.GF1586@8bytes.org>
	<AADFC41AFE54684AB9EE6CBC0274A5D19BE68777@SHSMSX101.ccr.corp.intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19BE689B8@SHSMSX101.ccr.corp.intel.com>
	<20181207102926.GM16835@8bytes.org>
	<AADFC41AFE54684AB9EE6CBC0274A5D19BE95394@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19BE95394-0J0gbvR4kThpB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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

Hi Kevin,

On Mon, Dec 10, 2018 at 02:06:44AM +0000, Tian, Kevin wrote:
> Can I interpret above as that you agree with the aux domain concept (i.e. one
> device can be linked to multiple domains) in general, and now we're just trying
> to address the remaining open in API level?

Yes, I thouht about alternatives, but in the end they are all harder to
use than the aux-domain concept. We just need to make sure that we have
a clear definition of what the API extension do and how they impact the
behavior of existing functions.

> > 	enum iommu_dev_features {
> > 		/* ... */
> > 		IOMMU_DEV_FEAT_AUX,
> > 		IOMMU_DEV_FEAT_SVA,
> > 		/* ... */
> > 	};
> > 
> 
> Does above represent whether a device implements aux/sva features,
> or whether a device has been enabled by driver to support aux/sva 
> features?

These represent whether the device together with the IOMMU support them,
basically whether these features are usable via the IOMMU-API.


> 
> > 	/* Check if a device supports a given feature of the IOMMU-API */
> > 	bool iommu_dev_has_feature(struct device *dev, enum
> > iommu_dev_features *feat);
> 
> If the latter we also need iommu_dev_set_feature so driver can poke
> it based on its own configuration.

Do you mean we need an explict enable-API for the features? I thought
about that too, but some features clearly don't need it and I didn't
want to complicate the usage. My assumption was that when the feature is
available, it is also enabled.

> > 	/* So we need a iommu_aux_detach_all()? */
> 
> for what scenario?

Maybe for detaching any PASID users from a device so that it can be
assigned to a VM as a whole. But I am not sure it is needed.

Regards,

	Joerg
