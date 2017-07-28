From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH v8 10/13] iommu/amd: Allocate memory below 4G for dev
	table if translation pre-enabled
Date: Fri, 28 Jul 2017 13:14:39 +0200
Message-ID: <20170728111439.GB3431@suse.de>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
	<1500627551-12930-11-git-send-email-bhe@redhat.com>
	<20170727155550.GO3610@suse.de> <20170728090619.GM24304@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170728090619.GM24304@x1>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 28, 2017 at 05:06:19PM +0800, Baoquan He wrote:
> Do you mean the allocation of amd_iommu_dev_table in
> early_amd_iommu_init() also need be addressed for 1st kernel? Seems we
> don't make sure that for 1st kernel, like adding GFP_DMA32 flag when
> allocate amd_iommu_dev_table in amd_iommu_dev_table
> early_amd_iommu_init().

Yes, exactly, the first device table also needs to be allocated with
GFP_DMA32 so that it ends up below 4GB.
