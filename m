From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/7] iommu/amd: Implement DOMAIN_ATTR_GEOMETRY attribute
Date: Wed, 11 Jul 2012 14:17:08 +0200
Message-ID: <20120711121708.GF25282@amd.com>
References: <1342003763-8139-1-git-send-email-joerg.roedel@amd.com>
	<1342003763-8139-3-git-send-email-joerg.roedel@amd.com>
	<C5ECD7A89D1DC44195F34B25E172658D13AA64@039-SN2MPN1-013.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D13AA64-RL0Hj/+nBVDYdknt8GnhQq4g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Sethi,

On Wed, Jul 11, 2012 at 11:47:39AM +0000, Sethi Varun-B16395 wrote:
> I am currently working on upstreaming the Freescale IOMMU driver. As
> discussed (with Scott Wood) a while back, this representation of the
> GEOMETRY attribute doesn't go well with our IOMMU implementation. Our
> representation of the geometry would be more complex and is certainly
> modifiable.  Our IOMMU allows for creating custom DMA mappings by
> defining a set of DMA sub windows within a given window. We need a
> mechanism for specifying the number of DMA subwindows as a part of the
> domain geometry. My suggestion would be to make the GEOMETRY attribute
> implementation dependent

Yeah, we had some discussions in the past and I came to the conclusion
that its best to wait for your code and decide then if and how to
change the interface to better suit your needs. The interface is not
exposed to userspace so we can easily change it.

People are waiting for this feature and I don't want to delay it further
unless it is absolutly necessary.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
