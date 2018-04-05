From: Christoph Hellwig <hch@lst.de>
Subject: Re: x86/dma conversion for v4.17-rc1 breaks sound / sst-acpi
        (commit 6e4bf5867783)
Date: Thu, 5 Apr 2018 23:14:21 +0200
Message-ID: <20180405211421.GA13851@lst.de>
References: <20180405205657.GA1788@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180405205657.GA1788@light.dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: hch@lst.de, thomas.lendacky@amd.com, tglx@linutronix.de, dwmw2@infradead.org, joro@8bytes.org, jdmason@kudzu.us, konrad.wilk@oracle.com, torvalds@linux-foundation.org, mulix@mulix.org, peterz@infradead.org, iommu@lists.linux-foundation.org, mingo@kernel.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 05, 2018 at 10:56:57PM +0200, Dominik Brodowski wrote:
> Christoph,
> 
> unfortunately, commit 6e4bf5867783 breaks sound on my Dell XPS13, see the
> dmesg diff between fec777c385b6 and 6e4bf5867783:

Very strange.  I'll need to spend some time untangling all that sound-soc
mess where it might be stuck.
