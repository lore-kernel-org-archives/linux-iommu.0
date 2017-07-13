From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC 0/2] arm-smmu-v3 tlbi-on-map option
Date: Thu, 13 Jul 2017 10:29:42 +0100
Message-ID: <fd71a432-0799-3c07-4071-c79bce20a561@arm.com>
References: <1499613303-30173-1-git-send-email-eric.auger@redhat.com>
 <20170712175454.GF15191@arm.com>
 <20170712223654-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170712223654-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, robin.murphy@arm.com, christoffer.dall@linaro.org, Marc.Zyngier@arm.com, alex.williamson@redhat.com, peterx@redhat.com
List-Id: iommu@lists.linux-foundation.org

On 12/07/17 23:07, Michael S. Tsirkin wrote:
[...]
> I think using hardware support for nesting is the right final
> solution. It will take some time though. Given this, what should
> we do meanwhile?
> 
> Assuming that's the final destination, a simple quirk like this
> seems to be preferable to virtio-iommu which we'll never be
> able to offload to hardware.

That's not entirely true. virtio-iommu will have an extension for hardware
nesting support. It was presented in my initial proposal, and I've made
significant progress since then.

Thanks,
Jean
