From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/5] iommu: Add DOMAIN_ATTR_WINDOWS domain attribute
Date: Tue, 5 Feb 2013 11:41:55 +0100
Message-ID: <20130205104155.GR25591@8bytes.org>
References: <1359983924-28952-1-git-send-email-joro@8bytes.org>
	<1359983924-28952-6-git-send-email-joro@8bytes.org>
	<C5ECD7A89D1DC44195F34B25E172658D373D2B@039-SN2MPN1-013.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D373D2B-RL0Hj/+nBVDYdknt8GnhQq4g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On Tue, Feb 05, 2013 at 09:14:40AM +0000, Sethi Varun-B16395 wrote:
> In case of PAMU, geometry would be meaningless without specifying the
> number of subwindows. If the API user specifies a geometry but fails
> to specify the number of required subwindows, we would assume a
> default (max supported) value, which may be incorrect. It's going to
> be really ugly. I think we should add the number of sub windows to the
> domain geometry. This parameter would be used in case of a window
> based iommu. So, a separate set_window API wouldn't be required.

I think this can all be implemented with the interface proposed here
together with a PAMU-specific DOMAIN_ATTR_PAMU_ENABLE attribute. Stuart
outlined in his RFC mail how this can be done. I don't consider this
ugly, it is rather a clean tradeoff between putting functionality into
the generic part of the IOMMU-API and putting it into the PAMU specific
part.

Regards,

	Joerg
