From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] avoid indirect calls for DMA direct mappings
Date: Thu, 6 Dec 2018 10:30:32 -0800
Message-ID: <CAHk-=whQ46wvdsXUS9BJkzQo-AuiCq-tAf1iP0i+G1Ym_M4pmw@mail.gmail.com>
References: <20181206153720.10702-1-hch@lst.de> <CAHk-=wgz6PFCm+XMWN31dRHzA3JcNP0x0Y-z5NMMw3dHhrDXAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wgz6PFCm+XMWN31dRHzA3JcNP0x0Y-z5NMMw3dHhrDXAw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, brouer@redhat.com, tariqt@mellanox.com, ilias.apalodimas@linaro.org, toke@toke.dk, robin.murphy@arm.com, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Dec 6, 2018 at 10:28 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Put another way, you made the fast case unnecessarily slow.

Side note: the code seems to be a bit confused about it, because
*some* cases test the fast case first, and some do it after they've
already accessed the pointer for the slow case.

So even aside from the performance and code generation issue (and
possible future "use a special bit pattern for the fast case"), it
would be good for _consistency_ to just always do the fast-case test
first.

                Linus
