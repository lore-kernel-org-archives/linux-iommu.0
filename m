From: Michael Wang <yun.wang-EIkl63zCoXaH+58JC4qpiA@public.gmane.org>
Subject: Re: [RFC PATCH v2] iommu/amd: gray the 'irq_remap_table' object for
	kmemleak
Date: Wed, 2 Dec 2015 12:38:03 +0100
Message-ID: <565ED81B.3020606@profitbricks.com>
References: <564EFF6A.2050709@profitbricks.com>
	<564F051E.9010703@profitbricks.com> <20151125150806.GG2064@8bytes.org>
	<5655D072.1000901@profitbricks.com> <565EC9F4.2050401@profitbricks.com>
	<CAHkRjk5QNQiNeJTcjKFQzpac_4us_3Ts1w4+uRw6TY16LbgsJA@mail.gmail.com>
	<565ECE54.5080706@profitbricks.com>
	<CAHkRjk5WzPT1gRaa=3qyrp1gcee9ZQKF_rU42FAu0C6ep8JPug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAHkRjk5WzPT1gRaa=3qyrp1gcee9ZQKF_rU42FAu0C6ep8JPug-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Catalin Marinas <catalin.marinas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


On 12/02/2015 12:31 PM, Catalin Marinas wrote:
> On 2 December 2015 at 10:56, Michael Wang <yun.wang-EIkl63zCoXaH+58JC4qpiA@public.gmane.org> wrote:
[snip]
> 
> I could copy your description but I don't currently have a way (nor
> time) to test the patch. If you plan to test it anyway, please feel
> free to include my diff (which I guess was badly re-formatted by
> gmail), I don't really mind which author it is (I found it easier to
> show a diff than explain in plain English ;)).

Unfortunately that's the same on my side... we already close the ticket
and I don't have resources to testing it again.

Joerg, this is really a tiny fix, would you mind to merge it into some
of your cleanup patch and testing them together? we are not in hurry,
just want to make sure the issue will get solved.

Regards,
Michael Wang

> 
