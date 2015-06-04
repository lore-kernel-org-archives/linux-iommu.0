From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [iommu:x86/vt-d 6/11] drivers/iommu/intel-iommu.c:5079:2-8:
	preceding lock on line 5061
Date: Thu, 4 Jun 2015 19:32:55 +0200
Message-ID: <20150604173255.GH16345@suse.de>
References: <201506050119.zh0T6mBM%fengguang.wu@intel.com>
	<alpine.DEB.2.10.1506041915090.2677@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1506041915090.2677@hadrien>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Cc: zhen-hual-VXdhtT5mjnY@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kbuild-JC7UmRfGjtg@public.gmane.org, Bill Sumner <billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 04, 2015 at 07:16:18PM +0200, Julia Lawall wrote:
> It looks suspicious.  Please take a look.

Yes, thanks for the report. Dan already sent a patch to fix this, I
applied it and then dropped it again and replaced it by a bigger rework
of the whole patch-set, as it has a lot of other issues as well. I am at
17 add-on patches now and will post (and apply) them soon.


	Joerg
