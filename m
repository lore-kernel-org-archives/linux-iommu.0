From: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC patch 28/41] dma/debug: Simplify stracktrace retrieval
Date: Wed, 10 Apr 2019 13:08:18 +0200
Message-ID: <20190410110818.GA13904@lst.de>
References: <20190410102754.387743324@linutronix.de> <20190410103646.130022106@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190410103646.130022106@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 10, 2019 at 12:28:22PM +0200, Thomas Gleixner wrote:
> Replace the indirection through struct stack_trace with an invocation of
> the storage array based interface.

This seems to be missing some context, at least stack_trace_save does
not actually exist in mainline.

Please always send the whole series out to everyone on the To and Cc
list, otherwise patch series are not reviewable.
