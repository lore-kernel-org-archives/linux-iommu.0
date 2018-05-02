From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] swiotlb: Fix inversed DMA_ATTR_NO_WARN test
Date: Wed, 2 May 2018 16:31:09 +0200
Message-ID: <1066dfa2-2f78-815d-c65a-9d09eb35458c@daenzer.net>
References: <20180501132411.2311-1-michel@daenzer.net>
 <786ca83f-45c4-264b-2aef-d84fb18d3d28@gmail.com>
 <CAKMK7uH2+v3_UUqXdCjz_8=H4VRt1zB+dgE99PuuPqd+XM2=-w@mail.gmail.com>
 <20180502124151.GA22857@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180502124151.GA22857@lst.de>
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Daniel Vetter <daniel@ffwll.ch>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On 2018-05-02 02:41 PM, Christoph Hellwig wrote:
> On Wed, May 02, 2018 at 02:18:56PM +0200, Daniel Vetter wrote:
>> Other dma-api backends like cma just shut up when __GFP_NOWARN is
>> passed. And afaiui Christoph Hellwig has plans to nuke the DMA_ATTR
>> stuff (or at least clean it up) - should we just remove
>> DMA_ATTR_NO_WARN and instead only look at __GFP_NOWARN?
> 
> No.  __GFP_NOWARN (and gfp_t flags in general) are the wrong interface
> for dma allocations and just cause problems.  I actually plan to
> get rid of the gfp_t argument in dma_alloc_attrs sooner, and only
> allow either GFP_KERNEL or GFP_DMA passed in dma_alloc_coherent.

How about GFP_TRANSHUGE_LIGHT? TTM uses that to opportunistically
allocate huge pages (GFP_TRANSHUGE can result in unacceptably long
delays with memory pressure).


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
