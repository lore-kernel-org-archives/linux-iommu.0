From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 06/20] dt-bindings: memory: tegra: Squash tegra20-gart
	into tegra20-mc
Date: Thu, 27 Sep 2018 13:41:21 -0500
Message-ID: <20180927184121.GA2459@bogus>
References: <20180924004153.8232-1-digetx@gmail.com>
	<20180924004153.8232-7-digetx@gmail.com>
	<20180924095530.GA21032@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180924095530.GA21032@ulmo>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Sep 24, 2018 at 11:55:30AM +0200, Thierry Reding wrote:
> On Mon, Sep 24, 2018 at 03:41:39AM +0300, Dmitry Osipenko wrote:
> > Splitting GART and Memory Controller wasn't a good decision that was made
> > back in the day. Given that the GART driver wasn't ever been used by
> > anything in the kernel, we decided that it will be better to correct the
> > mistakes of the past and merge two bindings into a single one. As a result
> > there is a DT ABI change for the Memory Controller that allows not to
> > break newer kernels using older DT and not to break older kernels using
> > newer DT, that is done by changing the 'compatible' of the node to
> > 'tegra20-mc-gart' and adding a new-required clock property. The new clock
> > property also puts the tegra20-mc binding in line with the bindings of the
> > later Tegra generations.
> > 
> > Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  .../bindings/iommu/nvidia,tegra20-gart.txt    | 14 ----------
> >  .../memory-controllers/nvidia,tegra20-mc.txt  | 27 +++++++++++++------
> >  2 files changed, 19 insertions(+), 22 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt
> > deleted file mode 100644
> > index 099d9362ebc1..000000000000
> > --- a/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt
> > +++ /dev/null
> > @@ -1,14 +0,0 @@
> > -NVIDIA Tegra 20 GART
> > -
> > -Required properties:
> > -- compatible: "nvidia,tegra20-gart"
> > -- reg: Two pairs of cells specifying the physical address and size of
> > -  the memory controller registers and the GART aperture respectively.
> > -
> > -Example:
> > -
> > -	gart {
> > -		compatible = "nvidia,tegra20-gart";
> > -		reg = <0x7000f024 0x00000018	/* controller registers */
> > -		       0x58000000 0x02000000>;	/* GART aperture */
> > -	};
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
> > index 7d60a50a4fa1..e55328237df4 100644
> > --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
> > +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
> > @@ -1,26 +1,37 @@
> >  NVIDIA Tegra20 MC(Memory Controller)
> >  
> >  Required properties:
> > -- compatible : "nvidia,tegra20-mc"
> > -- reg : Should contain 2 register ranges(address and length); see the
> > -  example below. Note that the MC registers are interleaved with the
> > -  GART registers, and hence must be represented as multiple ranges.
> > +- compatible : "nvidia,tegra20-mc-gart"
> > +- reg : Should contain 2 register ranges: physical base address and length of
> > +  the controller's registers and the GART aperture respectively.
> 
> Couldn't we have achieved the same thing by adding a reg-names property
> instead of using a different compatible string? After all we only change
> what information the DT provides, but the device is still a "tegra20-mc"
> device.

Yes, if we were adding a reg field, but we're changing what the 2 reg 
fields contain, so I think a new compatible is best.

Rob
