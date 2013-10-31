From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv3 01/19] [HACK] of: dev_node has struct device pointer
Date: Thu, 31 Oct 2013 10:35:24 -0600
Message-ID: <527286CC.9080404@wwwdotorg.org>
References: <20131025.112549.2040849946958069337.hdoyu@nvidia.com><20131025091104.GG19622@ulmo.nvidia.com><52718122.9000206@wwwdotorg.org>
	<20131031.101232.80781047726461143.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131031.101232.80781047726461143.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 10/31/2013 02:12 AM, Hiroshi Doyu wrote:
> Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Wed, 30 Oct 2013 22:58:58 +0100:
> 
>> On 10/25/2013 03:11 AM, Thierry Reding wrote:
>> ...
>>> So my proposed solution for the IOMMU case is to treat it the same
>>> as any other resources. Perhaps resource isn't the right word, but
>>> at the core the issue is the same. A device requires the services
>>> of an IOMMU so that it can be put into the correct address space.
>>> If the IOMMU is not available yet it cannot do that, so we simply
>>> return -EPROBE_DEFER and cause the probe to be retried later.
>>
>> Personally, I view deferred probe as being used when one device
>> requires either a resource /or/ a service provided by another, not
>> /just/ when there's a resource dependency. Hence, I think it fits
>> perfectly here.
>>
>> So I agree with Thierry: In other words, I think the solution is for
>> all devices that are affected by an IOMMU to have a property such as:
>>
>> iommu = <&iommu_phandle iommu_specifier>;
> 
> Agree
> 
>> (and the DT node for the IOMMU will contain e.g. an #iommu-cells property)
> 
> As explained in another mail[1], "#iommu-cells" could vary, depending
> on a device since it's arbitral number of arguments(IDs) right
> now. This could be a fixed size of bitmap(64), 2 cells since we know
> "64" would be enough in the future as well as below.

So, a device can generate transactions using n different IDs, yet those
IDs all fit into some specific number of bits if represented as a
bitmask rather than a list. The size of that bitmask would be a good
candidate for #iommu-cells.

...
> 	smmu: iommu {
> 	      #iommu-cells = <2>;
> 	};
> 
> 	deviceA {
> 	       iommu = <&smmu 0x00000000 0x00000040>;
> 	};
> 
> 	deviceB {
> 	       iommu = <&smmu 0x00000000 0x00000104>;
> 	};

So yes, that seems like a reasonable representation.

> But then we cannot use SWGROUP ID "macros" in DT files since DTC
> cannot perse OR("|") operations as below. Or can we?
...
> 	deviceB {
> 	       iommu = <&smmu  SWGROUP_ID_A | SWGROUP_ID_B>;
> 	};

dtc now supports math expressions. You need to wrap expressions in ()
for them to be recognized, so if you write the above as:

	       iommu = <&smmu (SWGROUP_ID_A | SWGROUP_ID_B)>;

... it should work fine.

> So I thought that arbitral length of arguments may be easier to read as
> below:
...
> 	deviceB {
> 	       iommu = <&smmu SWGROUP_ID_A
> 	       	       	      SWGROUP_ID_B>;
> 	};

The problem with that is that it doesn't allow for multiple IOMMUs to be
represented by one property. You need a fixed number (e.g. #iommu-cells)
of cells after the phandle in order to know where one IOMMU specifier
ends, and the next phandle/specifier starts. While multiple IOMMUs is
likely quite rare, I see no reason to force a lack of support for that
scenario by ignoring the standard phandle/fixed-length-specifier
property format.

>> ... and for the driver to explicitly parse that property, and wait
>> until the driver for iommu_phandle is ready. Exactly the same as any
>> other resource/service dependency.
>>
>> That will solve all the problems.
>>
>> The only downside is that every driver needs to contain code to parse
>> that property. However, I think that's just one function call; the
>> actual implementation of that function can be unified somewhere inside
>> core code in drivers/iommu/.
> 
> Yes, but only missing part now is that, we could do this with
> "bus_notifier", but the current bus_notifier doesn't have the feature
> to return error(-EPROBE_DEFER). This could be modified so that
> bus_notifier could return (-EPROBE_DEFER) to postpone
> probing. Alternatively this could be done in some core probe code as
> well as Thierry pointed out.
> 
> [1] In the reply of "[PATCHv3 14/19] iommu/tegra: smmu: Get "nvidia,memory-clients" from DT"

I think this should be done explicitly in drivers. It's much simpler,
and doesn't encode any knowledge of driver-specific bindings into some
common bus notifier code.
