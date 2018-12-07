From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [RFC] avoid indirect calls for DMA direct mappings
Date: Fri, 7 Dec 2018 17:05:58 +0100
Message-ID: <20181207170558.5679beae@redhat.com>
References: <20181206153720.10702-1-hch@lst.de>
        <CAHk-=wgz6PFCm+XMWN31dRHzA3JcNP0x0Y-z5NMMw3dHhrDXAw@mail.gmail.com>
        <20181206184330.GB30039@lst.de>
        <173bfba7-033d-93c4-6ef1-48c9e39c9efc@arm.com>
        <20181206200006.GA31548@lst.de>
        <e3e4c17e-ba6d-d743-04e5-7f240211b9bc@arm.com>
        <20181207012141.GA4256@lst.de>
        <20181207164435.18f8ffed@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181207164435.18f8ffed@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>, iommu@lists.linux-foundation.org, tariqt@mellanox.com, ilias.apalodimas@linaro.org, toke@toke.dk, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, brouer@redhat.com
List-Id: iommu@lists.linux-foundation.org

On Fri, 7 Dec 2018 16:44:35 +0100
Jesper Dangaard Brouer <brouer@redhat.com> wrote:

> On Fri, 7 Dec 2018 02:21:42 +0100
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > On Thu, Dec 06, 2018 at 08:24:38PM +0000, Robin Murphy wrote:  
> > > On 06/12/2018 20:00, Christoph Hellwig wrote:    
> > >> On Thu, Dec 06, 2018 at 06:54:17PM +0000, Robin Murphy wrote:    
> > >>> I'm pretty sure we used to assign dummy_dma_ops explicitly to devices at
> > >>> the point we detected the ACPI properties are wrong - that shouldn't be too
> > >>> much of a headache to go back to.    
> > >>
> > >> Ok.  I've cooked up a patch to use NULL as the go direct marker.
> > >> This cleans up a few things nicely, but also means we now need to
> > >> do the bypass scheme for all ops, not just the fast path.  But we
> > >> probably should just move the slow path ops out of line anyway,
> > >> so I'm not worried about it.  This has survived some very basic
> > >> testing on x86, and really needs to be cleaned up and split into
> > >> multiple patches..    
> > >
> > > I've also just finished hacking something up to keep the arm64 status quo - 
> > > I'll need to actually test it tomorrow, but the overall diff looks like the 
> > > below.    
> > 
> > Nice.  I created a branch that picked up your bits and also the ideas
> > from Linus, and the result looks reall nice.  I'll still need a signoff
> > for your bits, though.
> > 
> > Jesper, can you give this a spin if it changes the number even further?
> > 
> >   git://git.infradead.org/users/hch/misc.git dma-direct-calls.2
> > 
> >   http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-direct-calls.2  
> 
> I'll test it soon...
> 
> I looked at my perf stat recording on my existing tests[1] and there
> seems to be significantly more I-cache usage.

The I-cache pressure seems to be lower with the new branch, and
performance improved with 4.5 nanosec.

 
> Copy-paste from my summary[1]:
> [1] https://github.com/xdp-project/xdp-project/blob/master/areas/dma/dma01_test_hellwig_direct_dma.org#summary-of-results

Updated:

* Summary of results

Using XDP_REDIRECT between drivers RX ixgbe(10G) redirect TX i40e(40G),
via BPF devmap (used samples/bpf/xdp_redirect_map) . (Note choose
higher TX link-speed to assure that we don't to have a TX bottleneck).
The baseline-kernel is at commit [[https://git.kernel.org/torvalds/c/ef78e5ec9214][ef78e5ec9214]], which is commit just
before Hellwigs changes in this tree.

Performance numbers in packets/sec (XDP_REDIRECT ixgbe -> i40e):
 - 11913154 (11,913,154) pps - baseline compiled without retpoline
 -  7438283  (7,438,283) pps - regression due to CONFIG_RETPOLINE
 -  9610088  (9,610,088) pps - mitigation via Hellwig dma-direct-calls
 - 10049223 (10,049,223) pps - Hellwig branch dma-direct-calls.2

Do notice at these extreme speeds the pps number increase rabbit with
small changes, e.g. difference to new branch is:
 - (1/9610088-1/10049223)*10^9 = 4.54 nanosec faster

>From the inst per cycle, it is clear that retpolines are stalling the CPU
pipeline:

| pps        | insn per cycle |
|------------+----------------|
| 11,913,154 |           2.39 |
| 7,438,283  |           1.54 |
| 9,610,088  |           2.04 |
| 10,049,223 |           1.99 |
|            |                |


Strangely the Instruction-Cache is also under heavier pressure:

| pps        | l2_rqsts.all_code_rd | l2_rqsts.code_rd_hit | l2_rqsts.code_rd_miss |
|------------+----------------------+----------------------+-----------------------|
| 11,913,154 | 874,547              | 742,335              | 132,198               |
| 7,438,283  | 649,513              | 547,581              | 101,945               |
| 9,610,088  | 2,568,064            | 2,001,369            | 566,683               |
| 10,049,223 | 1,232,818            | 1,152,514            | 80,299                |
|            |                      |                      |                       |

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
