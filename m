From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 03/16] iommu: introduce iommu invalidate API function
Date: Thu, 12 Oct 2017 09:43:49 +0200
Message-ID: <20171012074349.GH30803@8bytes.org>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1507244624-39189-4-git-send-email-jacob.jun.pan@linux.intel.com>
	<20171010133542.juag7cwbivlb56sl@8bytes.org>
	<20171010150953.4095a045@jacob-builder>
	<A2975661238FB949B60364EF0F2C257439AF5F37@SHSMSX104.ccr.corp.intel.com>
	<20171011095126.GD30803@8bytes.org>
	<A2975661238FB949B60364EF0F2C257439AF61F5@SHSMSX104.ccr.corp.intel.com>
	<20171011121534.GG30803@8bytes.org>
	<3cdbce19-9264-b2d0-745b-8d32d5b8cfe7@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3cdbce19-9264-b2d0-745b-8d32d5b8cfe7-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: "Lan, Tianyu" <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Liu,
	Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Wysocki,
	Rafael J" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 11, 2017 at 01:48:00PM +0100, Jean-Philippe Brucker wrote:
> I wonder if SVM originated in OpenCL first, rather than intel? That's why
> I'm using it, but it is ambiguous. I'm not sure IOVM is precise enough
> though, since the name could as well be used without shared tables, for
> classical map/unmap and IOVAs. Kevin Tian suggested SVA "Shared Virtual
> Addressing" last time, which is a little more clear than SVM and isn't
> used elsewhere in the kernel either.

SVA sounds even better. Feel free to use that for all the PRI/PASID
related code.


Regards,

	Joerg
