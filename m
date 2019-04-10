From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH v5 4/6] s390/pci: add support for generic boot option
 iommu.dma_mode
Date: Wed, 10 Apr 2019 13:46:48 +0200 (CEST)
Message-ID: <alpine.LFD.2.21.1904101346060.1774@schleppi>
References: <20190409125308.18304-1-thunder.leizhen@huawei.com> <20190409125308.18304-5-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190409125308.18304-5-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, John Garry <john.garry@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc <linux-doc@vger.kernel.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, David Woodhouse <dw>
List-Id: iommu@lists.linux-foundation.org

On Tue, 9 Apr 2019, Zhen Lei wrote:
> s390_iommu=strict is equivalent to iommu.dma_mode=strict.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Acked-by: Sebastian Ott <sebott@linux.ibm.com>
