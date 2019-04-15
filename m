From: Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: [PATCH 1/1] swiotlb: save io_tlb_used to local variable before
 leaving critical section
Date: Mon, 15 Apr 2019 20:08:20 +0800
Message-ID: <f10187e3-b84c-6c8c-2dae-09059a5f3270@oracle.com>
References: <1555069106-2964-1-git-send-email-dongli.zhang@oracle.com>
 <5bdc3265-e5a4-e8c8-9098-0bba18a66f19@oracle.com>
 <38f6f868-013e-5619-b939-a8273fc64ee4@oracle.com>
 <CAPbh3rvyVd_D9tMfE-Bo2JmdabaiQnaipmmadc67tUt_Lrt2gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPbh3rvyVd_D9tMfE-Bo2JmdabaiQnaipmmadc67tUt_Lrt2gw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: konrad@darnok.org
Cc: joe.jin@oracle.com, iommu@lists.linux-foundation.org, konrad.wilk@oracle.com, haakon.bugge@oracle.com, robin.murphy@arm.com, linux-kernel@vger.kernel.org, hch@lst.de
List-Id: iommu@lists.linux-foundation.org



On 04/15/2019 07:26 PM, Konrad Rzeszutek Wilk wrote:
> 
> 
> On Mon, Apr 15, 2019, 2:50 AM Dongli Zhang <dongli.zhang@oracle.com
> <mailto:dongli.zhang@oracle.com>> wrote:
> 
>     As the patch to be fixed is still in Konrad's own tree, I will send the v2 for
>     the patch to be fixed, instead of an incremental fix.
> 
> 
> I squashed it in.

Thank you very much!

I saw it is at:

https://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git/commit/?h=devel/for-linus-5.1&id=53b29c336830db48ad3dc737f88b8c065b1f0851

Dongli Zhang
