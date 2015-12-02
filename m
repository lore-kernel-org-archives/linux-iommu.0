From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH v2] iommu/amd: gray the 'irq_remap_table' object for
	kmemleak
Date: Wed, 2 Dec 2015 13:56:36 +0100
Message-ID: <20151202125636.GE18805@8bytes.org>
References: <564F051E.9010703@profitbricks.com>
	<20151125150806.GG2064@8bytes.org>
	<5655D072.1000901@profitbricks.com>
	<565EC9F4.2050401@profitbricks.com>
	<CAHkRjk5QNQiNeJTcjKFQzpac_4us_3Ts1w4+uRw6TY16LbgsJA@mail.gmail.com>
	<565ECE54.5080706@profitbricks.com>
	<CAHkRjk5WzPT1gRaa=3qyrp1gcee9ZQKF_rU42FAu0C6ep8JPug@mail.gmail.com>
	<565ED81B.3020606@profitbricks.com>
	<20151202115142.GD18805@8bytes.org>
	<565EE4AA.4070309@profitbricks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <565EE4AA.4070309-EIkl63zCoXaH+58JC4qpiA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Michael Wang <yun.wang-EIkl63zCoXaH+58JC4qpiA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Catalin Marinas <catalin.marinas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Dec 02, 2015 at 01:31:38PM +0100, Michael Wang wrote:
> It's not my work or your work... it's a defect in the module and maintainer
> should take responsibility on fixing it, correct?

No, its a false positive from an in-kernel checking tool, the iommu
driver is correct. You just sent a patch to silence the false positive
report.

> We're very willing to help, but as I mentioned we are out of resource for
> testing at this moment, but we can send you a new patch without testing,
> will that works for you?

This should be testable on any AMD IOMMU system with working interrupt
remapping. I will probably have no time to test this, if you really
can't test yourself, try to get a Tested-by from someone else.



	Joerg
