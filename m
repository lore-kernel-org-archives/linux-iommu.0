From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC PATCH 0/6] Auxiliary IOMMU domains and Arm SMMUv3
Date: Tue, 23 Oct 2018 22:08:18 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19BE1E39A@SHSMSX101.ccr.corp.intel.com>
References: <20181019181158.2395-1-jean-philippe.brucker@arm.com>
	<20181021194426.GA11201@araj-mobl1.jf.intel.com>
	<d45c5222-68e9-1d6e-730b-bb8dbc060586@arm.com>
	<1540314963.21962.20.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1540314963.21962.20.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org" <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: "rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Raj, Ashok
> Sent: Wednesday, October 24, 2018 1:17 AM
> 
> >
> > But that's not reason enough to completely disable PASID for the
> > device,
> > it could be the only one bound to that process, or PASID could be
> > only
> > used privately by the host device driver.
> 
> Agree, there could be other use cases.
> 
> If the device was already attached during boot the driver comes early
> to get the low PASID space. If the device was hot-added and the PASID
> supported by device wasn't available its going to fail.
> 
> Enforcing something that will always work will be more reliable. But i
> agree it maybe too strict for some cases.
> 
> Maybe its a IOMMU enforced limit for the platform on the minimum
> requirement for consistency.
> 

what about keeping the flexibility in common logic (e.g. allowing 
pasid_min and pasid_max in PASID allocator, detecting PASID
width limitation at binding time, etc.), while letting vendor driver
to vote disabling PASID on device based on its own need (e.g. if
not supporting 20bit width).

Thanks
kevin
