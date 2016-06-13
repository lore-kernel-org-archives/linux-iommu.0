From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [E1000-devel] AMD-Vi: Event logged IO_PAGE_FAULT - ixgbe
	Detected Tx Unit Hang - Reset adapter - master disable timed out
Date: Mon, 13 Jun 2016 11:08:03 +0200
Message-ID: <20160613090803.GC29948@suse.de>
References: <loom.20160606T232112-817@post.gmane.org>
	<CAKgT0UfEGS_QzM1phGKRV1hDgcnAwX-BqMkyQ6KJUOv82_kCiA@mail.gmail.com>
	<nj64hf$9v5$1@ger.gmane.org>
	<CAKgT0UfKUkrsXqLm4KdjXgLZ6QXZp5Rf-yYA3pBSzc1=ghJ4CQ@mail.gmail.com>
	<njbvjb$40r$1@ger.gmane.org>
	<CAKgT0UeFM1jYTU83YFohxUHWuJeTYfWDpdFM2CDQCutmf_vXvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKgT0UeFM1jYTU83YFohxUHWuJeTYfWDpdFM2CDQCutmf_vXvA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alexander Duyck <alexander.duyck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "e1000-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <e1000-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Lutz Vieweg <lvml-i6VILw57VWU@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 09, 2016 at 09:03:40AM -0700, Alexander Duyck wrote:
> >> Jun  9 14:40:09 computer kernel: AMD-Vi: Event logged [IO_PAGE_FAULT device=04:00.0 domain=0x000e address=0x00000000000178c0 flags=0x0050]
> >> Jun  9 14:40:09 computer kernel: AMD-Vi: Event logged [IO_PAGE_FAULT device=04:00.0 domain=0x000e address=0x0000000000017900 flags=0x0050]

Some more context would be helpful. Which kernel version was the last
that worked and with which version do you start to see these messages?


	Joerg
