From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] iommu/arm-smmu: Restrict domain attributes to
	UNMANAGED domains
Date: Thu, 26 Jan 2017 18:06:09 +0100
Message-ID: <20170126170609.GC27598@8bytes.org>
References: <1484849955-1871-1-git-send-email-will.deacon@arm.com>
	<1484849955-1871-2-git-send-email-will.deacon@arm.com>
	<89d795b9-a6d7-7f41-705c-b918ee66ebf0@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <89d795b9-a6d7-7f41-705c-b918ee66ebf0-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 19, 2017 at 06:41:34PM +0000, Robin Murphy wrote:
> For the sake of discussion, would it make sense to enforce this in
> domain_set_attr() itself? The intersection of drivers providing these
> callbacks and drivers supporting anything other than unmanaged domains
> is currently these two below, so it clearly wouldn't break anything to
> put this check in core code today. Looking forward, is there likely to
> be any plausible situation where users of a managed domain would be
> legitimate in mucking about with its attrs, on any platform?

No, this belongs in driver code. I am pretty certain there will be a use
for attributes in unmanaged domains at some point. Crazy things happen
all the time :)


	Joerg
