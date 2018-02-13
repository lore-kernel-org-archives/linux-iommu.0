From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: Kdump kernel hang when set amd_iommu=off
Date: Tue, 13 Feb 2018 14:25:20 +0100
Message-ID: <20180213132520.nqn5osmgsubzjzcq@8bytes.org>
References: <20180126080622.GC1759@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180126080622.GC1759-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Baoquan,

On Fri, Jan 26, 2018 at 04:06:22PM +0800, Baoquan He wrote:
> Saw Huawei's bug report about kdump kernel hang when intel_iommu=off 
> is set. I met the similar problem in amd system, only set amd_iommu=off
> in kdump kernel, it means amd_iommu is on in 1st kernel.
> 
> I am reading doc and code, trying to debug. Please help have a look when
> convenient, see if there's hint or direction.

Yeah, I know that this is broken on the AMD-IOMMU side. Problem is that
the IOMMU hardware needs to be disabled in the kdump kernel when
amd_iommu=off is on the command-line. I'll look into fixing that.

I thought we fixed this a while ago already for VT-d, is it broken
again?


	Joerg
