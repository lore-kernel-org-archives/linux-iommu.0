From: Vlastimil Babka <vbabka-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH 3/3] mm: wire up GFP flag passing in
	dma_alloc_from_contiguous
Date: Fri, 20 Jan 2017 14:35:26 +0100
Message-ID: <139e94c3-4d03-de35-0c91-217c73c0f5f2@suse.cz>
References: <20170119170707.31741-1-l.stach@pengutronix.de>
	<20170119170707.31741-3-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170119170707.31741-3-l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Michal Hocko <mhocko-IBi9RG/b67k@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, "H . Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, patchwork-lst-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, kvm-ppc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alexander Graf <agraf-IBi9RG/b67k@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 01/19/2017 06:07 PM, Lucas Stach wrote:
> The callers of the DMA alloc functions already provide the proper
> context GFP flags. Make sure to pass them through to the CMA
> allocator, to make the CMA compaction context aware.
> 
> Signed-off-by: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Acked-by: Vlastimil Babka <vbabka-AlSwsSmVLrQ@public.gmane.org>
