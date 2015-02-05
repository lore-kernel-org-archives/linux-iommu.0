From: Oded Gabbay <oded.gabbay@amd.com>
Subject: Re: [PATCH v2] iommu/amd: Use wait_event in put_pasid_state_wait
Date: Thu, 5 Feb 2015 14:23:10 +0200
Message-ID: <54D360AE.8090603@amd.com>
References: <1423062622-28257-1-git-send-email-joro@8bytes.org>
 <20150204163450.GD5029@twins.programming.kicks-ass.net>
 <20150205114020.GQ3702@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20150205114020.GQ3702@8bytes.org>
Sender: owner-linux-aio@kvack.org
To: Joerg Roedel <joro@8bytes.org>, Peter Zijlstra <peterz@infradead.org>
Cc: iommu@lists.linux-foundation.org, Benjamin LaHaise <bcrl@kvack.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-aio@kvack.org, linux-kernel@vger.kernel.org, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org



On 02/05/2015 01:40 PM, Joerg Roedel wrote:
> So this should be the correct version then.
>
>  From 2a52250e542d8964c8285a37b71fe838a44c05c4 Mon Sep 17 00:00:00 2001
> From: Joerg Roedel<jroedel@suse.de>
> Date: Wed, 4 Feb 2015 15:50:38 +0100
> Subject: [PATCH 1/2] iommu/amd: Use wait_event in put_pasid_state_wait
>
> Now that I learned about possible spurious wakeups this
> place needs fixing too. Replace the self-coded sleep variant
> with the generic wait_event() helper.
>
> Signed-off-by: Joerg Roedel<jroedel@suse.de>

Tested-by: Oded Gabbay <oded.gabbay@amd.com>

	Oded

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
