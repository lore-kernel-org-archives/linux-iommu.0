From: Michael Wang <yun.wang-EIkl63zCoXaH+58JC4qpiA@public.gmane.org>
Subject: Re: [RFC PATCH v2] iommu/amd: gray the 'irq_remap_table' object for
	kmemleak
Date: Wed, 2 Dec 2015 14:01:55 +0100
Message-ID: <565EEBC3.5050807@profitbricks.com>
References: <564F051E.9010703@profitbricks.com>
	<20151125150806.GG2064@8bytes.org> <5655D072.1000901@profitbricks.com>
	<565EC9F4.2050401@profitbricks.com>
	<CAHkRjk5QNQiNeJTcjKFQzpac_4us_3Ts1w4+uRw6TY16LbgsJA@mail.gmail.com>
	<565ECE54.5080706@profitbricks.com>
	<CAHkRjk5WzPT1gRaa=3qyrp1gcee9ZQKF_rU42FAu0C6ep8JPug@mail.gmail.com>
	<565ED81B.3020606@profitbricks.com> <20151202115142.GD18805@8bytes.org>
	<565EE4AA.4070309@profitbricks.com> <20151202125315.GB3910@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151202125315.GB3910-fF5Pk5pvG8Y@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Catalin Marinas <catalin.marinas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 12/02/2015 01:53 PM, Borislav Petkov wrote:
> On Wed, Dec 02, 2015 at 01:31:38PM +0100, Michael Wang wrote:
>> It's not my work or your work... it's a defect in the module and maintainer
>> should take responsibility on fixing it, correct?
> 
> Well, you said "actually we just want to get rid of this annoying report
> on obj won't leak..."
> 
> It sounds to me like you want to have something fixed. So you do the
> patch properly, add to the commit message why exactly you're doing it
> and test it. Like everyone else.

Yeah.. it's a little complicated since we have our own kernel tree and this
won't be a problem for us, but we really prefer to help fix it in mainline
too, as long as this is really a defect, so others could save time on research
in future.

But seems like we can only wait for another chance to confirm the another
solution, frankly speaking I think we both will forgot this soon... fortunately
it's not that critical :-P

Regards,
Michael Wang

> 
