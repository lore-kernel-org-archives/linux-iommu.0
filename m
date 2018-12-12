From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC PATCH 0/6] Auxiliary IOMMU domains and Arm SMMUv3
Date: Wed, 12 Dec 2018 10:03:48 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19BE9D851@SHSMSX101.ccr.corp.intel.com>
References: <e22e3631-2ecb-664d-5666-8e0f865dec83@linux.intel.com>
	<20181107164323.GA19831@8bytes.org>
	<758bb120-5bc0-1e2d-ccd0-9be0bcc5d8bc@linux.intel.com>
	<20181123112125.GF1586@8bytes.org>
	<AADFC41AFE54684AB9EE6CBC0274A5D19BE68777@SHSMSX101.ccr.corp.intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19BE689B8@SHSMSX101.ccr.corp.intel.com>
	<20181207102926.GM16835@8bytes.org>
	<AADFC41AFE54684AB9EE6CBC0274A5D19BE95394@SHSMSX101.ccr.corp.intel.com>
	<20181210085745.GN16835@8bytes.org>
	<AADFC41AFE54684AB9EE6CBC0274A5D19BE9D6CA@SHSMSX101.ccr.corp.intel.com>
	<20181212095403.GU16835@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181212095403.GU16835-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
To: "'joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org'" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: 'joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org' [mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org]
> Sent: Wednesday, December 12, 2018 5:54 PM
> 
> Hi Kevin,
> 
> On Wed, Dec 12, 2018 at 09:31:27AM +0000, Tian, Kevin wrote:
> > > From: 'joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org'
> > > Sent: Monday, December 10, 2018 4:58 PM
> > > These represent whether the device together with the IOMMU support
> > > them,
> > > basically whether these features are usable via the IOMMU-API.
> >
> > "device together with IOMMU" or just "IOMMU itself"?
> 
> No, it should mean device together with IOMMU support it. It is a way
> for users of the IOMMU-API to check whether they can successfully use
> the aux-specific functions.
> 
> > however there is a problem with aux. A device may implement both
> > SR-IOV and Scalable IOV capabilities, but at any time only one of them
> > can be enabled. Driver will provide interfaces for end user to choose.
> > In such case we cannot assume that device-side Scalable-IOV can be
> > always enabled while IOMMU is in scalable mode.
> >
> > It works better if we position those features just representing IOMMU
> > support only. In that case, aux is related only to scalable mode of IOMMU
> > itself, which is orthogonal to whether device side supports SIOV.
> 
> Yeah, but we don't make that decision in the IOMMU code. Whether the
> device exposes SR-IOV or PASID based isolation is decided in PCI code
> based on user input (SR-IOV is also enabled in PCI code and IOMMU just
> uses the new devices that appear).
> 
> Only if the user enabled scalable mode on the device and the IOMMU
> supports it too, the feature-check function returns true for the aux
> feature.
> 

Then this is another proof for an enable/disable part in API. :-)

Thanks
kevin
