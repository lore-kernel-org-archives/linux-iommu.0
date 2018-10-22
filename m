From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-mapping: move the remap helpers to a separate file
Date: Mon, 22 Oct 2018 10:56:05 +0200
Message-ID: <20181022085605.GA18755@lst.de>
References: <20181014181651.22971-1-hch@lst.de> <e2a05b3e-7306-4710-1591-0a39278b5002@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e2a05b3e-7306-4710-1591-0a39278b5002@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laura Abbott <labbott@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Sun, Oct 21, 2018 at 12:41:42AM -0700, Laura Abbott wrote:
>> The dma remap code only really makes sense for not cache coherent
>> architectures, and currently is only used by arm, arm64 and xtensa.
>> Split it out into a separate file with a separate Kconfig symbol.
>>
>> [Laura: you wrote this code back then, do you have a sensible
>>   copyright statement to add, given that the mapping.c statement
>>   obviously does not match your code that was written much later]
>>
>
> Hmmmmm, that was written and committed via my codeaurora.org e-mail
> address. Probably best to use "Copyright (c) 2014, The Linux Foundation"
> since that was the standard. If you want,
>
> Acked-by: Laura Abbott <labbott@redhat.com>

Thanks!
