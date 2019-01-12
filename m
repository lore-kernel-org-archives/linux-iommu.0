From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] remove dma_zalloc_coherent
Date: Sat, 12 Jan 2019 10:52:30 -0800
Message-ID: <CAHk-=wjurJwdQFwVtMLCuvTroZMpY1PGuSEwUq=jf5Uv9fd10A@mail.gmail.com>
References: <20190112181355.GA31454@infradead.org> <CAHk-=wiYxY9H-XDgawJd+Y4AM4qtK=7RQZ_GhswcUSYWw=eckA@mail.gmail.com>
 <20190112183153.GA4192@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190112183153.GA4192@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: iommu@lists.linux-foundation.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, Jan 12, 2019 at 10:31 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Many users don't need it for security reasons, but given that x86
> and arm have done it forever various drivers started relying on the
> behavior.

Ok, I guess that's a pretty strong argument.

              Linus
