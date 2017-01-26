From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/5] iommu/arm-smmu: Restrict domain attributes to
	UNMANAGED domains
Date: Thu, 26 Jan 2017 17:57:13 +0000
Message-ID: <20170126175712.GP14167@arm.com>
References: <1484849955-1871-1-git-send-email-will.deacon@arm.com>
	<1484849955-1871-2-git-send-email-will.deacon@arm.com>
	<20170126170329.GB27598@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170126170329.GB27598-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 26, 2017 at 06:03:30PM +0100, Joerg Roedel wrote:
> On Thu, Jan 19, 2017 at 06:19:11PM +0000, Will Deacon wrote:
> > The ARM SMMU drivers provide a DOMAIN_ATTR_NESTING domain attribute,
> > which allows callers of the IOMMU API to request that the page table
> > for a domain is installed at stage-2, if supported by the hardware.
> > 
> > Since setting this attribute only makes sense for UNMANAGED domains,
> > this patch returns -ENODEV if the domain_{get,set}_attr operations are
> > called on other domain types.
> 
> Isn't -EINVAL more suitable here? In the end the domain passed in is
> invalid because it does not support attributes, no?

Sure, I can change that.

Will
