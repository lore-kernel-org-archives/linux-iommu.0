From: Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 4/4] iommu: Add domain window handling functions
Date: Tue, 5 Feb 2013 03:41:03 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E150354A1DC@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1359582228-21552-1-git-send-email-joro@8bytes.org>
	<1359582228-21552-5-git-send-email-joro@8bytes.org>
	<C5ECD7A89D1DC44195F34B25E172658D3670ED@039-SN2MPN1-013.039d.mgd.msft.net>
	<20130204130214.GN25591@8bytes.org> <1360020980.14901.17@snotra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1360020980.14901.17@snotra>
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
To: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Monday, February 04, 2013 5:36 PM
> To: Joerg Roedel
> Cc: Sethi Varun-B16395; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Wood Scott-
> B07421; Yoder Stuart-B08248
> Subject: Re: [PATCH 4/4] iommu: Add domain window handling functions
> 
> On 02/04/2013 07:02:14 AM, Joerg Roedel wrote:
> > On Thu, Jan 31, 2013 at 09:32:26AM +0000, Sethi Varun-B16395 wrote:
> > > We need a mechanism to determine the maximum number of subwindows
> > supported by PAMU. How about representing it in the iommu_domain
> > structure:
> > > struct  iommu_domain {
> > > 	struct iommu_ops *ops;
> > > 	void *priv;
> > > 	iommu_fault_handler_t handler;
> > > 	void *handler_token;
> > > 	struct iommu_domain_geometry geometry;
> > > 	u32 max_sub_windows; -----> maximum number of sub windows
> > supported by the hardware.
> > > }
> >
> > I`ll leave that flag to the private-data of the IOMMU domain. Instead
> > I
> > added a DOMAIN_ATTR_WINDOWS attribute to get/set the number of
> > subwindows. I'll post the updated patch-set soon.
> 
> If it's private data, how does the caller know what sort of geometry it
> can request?

The way I thought this could work based on the patch that Joerg posted today
was that when the domain is created the caller could read the DOMAIN_ATTR_WINDOWS 
domain_get_windows() to determine the max.  The initial/default value is the
max.  The caller could then set a smaller value if they wanted to.

Stuart
