From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv3 01/19] [HACK] of: dev_node has struct device pointer
Date: Fri, 25 Oct 2013 10:22:02 +0200
Message-ID: <20131025.112202.47792301040951621.hdoyu@nvidia.com>
References: <20131024.122115.1035609747068925560.hdoyu@nvidia.com><20131025001038.77299C403B6@trevor.secretlab.ca><20131025075652.GB19622@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131025075652.GB19622-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Fri, 25 Oct 2013 09:56:55 +0200:

> I suspect that there will be enough differences between the various
> IOMMU implementations that we won't be able to have a unified binding
> (especially for how to associate devices with a particular virtual
> address space), but perhaps that could be solved with something like an
> .of_xlate() that IOMMU drivers implement, much like we've done with most
> other subsystems too.
> 
> The binding for Tegra's IOMMU currently only uses the HW IDs (or a mask)
> to put a device into a given address space, but I think that could be
> easily extended to something like:
> 
> 	memory-clients = <&iommu MASK>;
> 
> Or similar. If other information is required, we could encode that into
> a multi-cell specifier. Perhaps we could even leave away the phandle
> since typically there will only be a single IOMMU in the system?
> 
> Does that sound reasonable? Hiroshi is much more familiar with IOMMUs,
> so I'd like to get his opinion on the above as well.

I think that the above may be possible, but I'd like to listen from
other IOMMU SOC maintainers.

A brief explanation for "memory-clients":

In tegra, every H/W has its own memory-client ID, and it can be
associated to any address spaces. The above "memory-cilents" is used
to indicate which ID a device has in DT. If the other SOC IOMMUs need
this kind of "memory-clients", this would be standarized. Any comment?

At least arm-smmu seems to have the following. multiple IOMMUs can be
handled with this.


- smmu-parent   : When multiple SMMUs are chained together, this
                  property can be used to provide a phandle to the
                  parent SMMU (that is the next SMMU on the path going
                  from the mmu-masters towards memory) node for this
                  SMMU.
