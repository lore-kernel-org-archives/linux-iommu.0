From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.0 008/262] swiotlb: add checks for the return
 value of memblock_alloc*()
Date: Wed, 3 Apr 2019 20:56:44 -0400
Message-ID: <20190404005644.GI16241@sasha-vm>
References: <20190327180158.10245-1-sashal@kernel.org>
 <20190327180158.10245-8-sashal@kernel.org>
 <20190328055520.GA14864@rapoport-lnx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190328055520.GA14864@rapoport-lnx>
Sender: stable-owner@vger.kernel.org
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Christoph Hellwig <hch@lst.de>, "David S. Miller" <davem@davemloft.net>, Dennis Zhou <dennis@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Guo Ren <ren_guo@c-sky.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Juergen Gross <jgross@suse.com>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Paul Burton <paul.burton@mips.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 28, 2019 at 07:55:20AM +0200, Mike Rapoport wrote:
>Hi,
>
>On Wed, Mar 27, 2019 at 01:57:43PM -0400, Sasha Levin wrote:
>> From: Mike Rapoport <rppt@linux.ibm.com>
>>
>> [ Upstream commit a0bf842e89a3842162aa8514b9bf4611c86fee10 ]
>>
>> Add panic() calls if memblock_alloc() returns NULL.
>>
>> The panic() format duplicates the one used by memblock itself and in
>> order to avoid explosion with long parameters list replace open coded
>> allocation size calculations with a local variable.
>
>This patch is a part of a series that removes panic() calls from memblock
>allocators rather than a fix.

I've dropped it, thanks!
