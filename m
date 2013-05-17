From: Andreas Herrmann <andreas.herrmann@calxeda.com>
Subject: Re: [PATCH v2] documentation: iommu: add description of ARM System
 MMU binding
Date: Fri, 17 May 2013 22:16:39 +0200
Message-ID: <20130517201639.GL10369@alberich>
References: <1365789727-5371-1-git-send-email-will.deacon@arm.com>
 <20130513095020.GB10369@alberich>
 <20130513095846.GC29814@mudshark.cambridge.arm.com>
 <20130513104147.GF10369@alberich>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20130513104147.GF10369@alberich>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: Olav Haugan <ohaugan@codeaurora.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, May 13, 2013 at 12:41:47PM +0200, Andreas Herrmann wrote:
> On Mon, May 13, 2013 at 05:58:46AM -0400, Will Deacon wrote:
> > On Mon, May 13, 2013 at 10:50:20AM +0100, Andreas Herrmann wrote:

[snip]

> > > I also think that it is more useful to move the stream-id property to
> > > the device node of a master device. (It's a characteristic of the
> > > master device not of the SMMU.) Currently with multiple stream IDs per
> > > master device you have repeated entries in the mmu-master property.
> > 
> > The problem with that approach is how to handle StreamID remastering. This
> > can and will happen, so the StreamID for a device is actually a property of
> > both the device *and* a particular point in the bus topology. Putting this
> > information in the device nodes will drag topology information all over the
> > place and I don't think it will make things clearer to read or easier to parse.
> 
> Ok, good point, didn't think about that.
> And agreed, adding remastered StreamIDs as a property to a device node is odd.
> 
> > > But all that is needed is to point (once) to each mmu-master in the
> > > SMMU device node. Then you should be able to look up the corresponding
> > > stream IDs in the device node for each mmu-master.
> > 
> > Again, you also need to tie in topology information if you go down this
> > route.

I still don't like the approach of having two independend lists that
must be in sync to associate a master with its stream-ids.

Why? Say you have 8 masters for an SMMU with 1 or 2 stream-ids each:

     	 smmu {
		...
                mmu-masters = <&dma0>, <&dma0>, <&dma1>, <&dma1>,
			      <&dma2>, <&dma2>, <&dma4>, <&dma4>,
			      <&dma5>, <&dma6>, <&dma7>, <&dma8>;
                stream-ids =	<0>, <1>, <2>, <3>,
				<4>, <5>, <6>, <7>,
		                <8>, <9>, <0xa>, <0xb>;
	}

Couldn't we use of_phandle_args for this purpose? So your example

+        smmu {
		 ...
+                mmu-masters = <&dma0>,
+                              <&dma0>,
+                              <&dma1>;
+                stream-ids  = <0xd01d>,
+                              <0xd01e>,
+                              <0xd11c>;
+        };

would look like

	dma0 {
		...
		#stream-id-cells = <2>
		...
	}

	dma1 {
		...
		#stream-id-cells = <1>
		...
	}

        smmu {
		...
		mmu-masters = <&dma0 0xd01d 0xd01e
			       &dma1 0xd11c>,
       };

and my example would be converted to

	smmu {
		...
                mmu-masters = <&dma0 0 1 &dma1 2 3 &dma2 4 5
			       &dma4 6 7 &dma5 8 &dma6 9
			       &dma7 0xa &dma8 0xb>
		...
	}

where each master has #stream-id-cells property with value 1 or 2.
And if dma4 has #stream-id-cells = <1>, the parsing code quickly
notifies us about an error whereas such an error can't be noticed
right from the beginning with the two-list-approach. In this example
stream-id 6 belongs to dma3 which was completely ommitted in both
descriptions.

Of course usage of of_phandle_args would restrict the number of
stream-ids per master to 8 (which is currently used as
MAX_PHANDLE_ARGS). But I don't think that this is a restriction in
practice or do you expect to have more than 8 stream-ids per master
(ie. per struct device in Linux)?


Andreas
