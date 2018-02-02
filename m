From: Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] iommu/vt-d: add NUMA awareness to intel_alloc_coherent()
Date: Fri, 2 Feb 2018 10:59:43 -0800
Message-ID: <CANn89i+FBn3fttEyU_znAd-+8BgM7VZogFeeZPA7_zubChFpBA@mail.gmail.com>
References: <1517438756.3715.108.camel@gmail.com> <20180202185301.GA8232@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180202185301.GA8232@infradead.org>
Sender: netdev-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Benjamin Serebrin <serebrin@google.com>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, netdev <netdev@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 2, 2018 at 10:53 AM, Christoph Hellwig <hch@infradead.org> wrote:
> I've got patches pending to replace all that code with
> dma_direct_alloc, which will do the right thing.  They were
> submitted for 4.16, and I will resend them after -rc1.

I see, thanks Christoph !
