From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv4 2/7] driver/core: Populate IOMMU'able devices in order
Date: Wed, 13 Nov 2013 10:53:36 -0700
Message-ID: <5283BCA0.40300@wwwdotorg.org>
References: <1384158718-4756-3-git-send-email-hdoyu@nvidia.com>
	<5282BAFC.8070405@wwwdotorg.org>
	<20131113143804.GA11928@mudshark.cambridge.arm.com>
	<20131113.180610.823304139654159769.hdoyu@nvidia.com>
	<20131113173142.GF11928@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131113173142.GF11928-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 11/13/2013 10:31 AM, Will Deacon wrote:
> On Wed, Nov 13, 2013 at 04:06:10PM +0000, Hiroshi Doyu wrote:
>> Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote @ Wed, 13 Nov 2013 15:38:04 +0100:
>>
>>> On Tue, Nov 12, 2013 at 11:34:20PM +0000, Stephen Warren wrote:
>>>> SMMU:
>>>>     smmu: smmu@xxxxxx {
>>>>         #smmu-cells = <1>;
>>>>     }
>>>>
>>>> Affected device:
>>>>     smmus = <&smmu 1>;
>>>>     (perhaps with smmu-names too)
>>>>
>>>> That would allow the DT to represent basically arbitrary HW configurations.
>>>>
>>>> The implementation of this patch would then be almost as trivial; you'd
>>>> just need to walk the smmus property to find each phandle in turn, just
>>>> like any other phandle+specifier property, and validate that the SMMU
>>>> driver was already probe()d for each.
>>>
>>> There are a few problems with that:
>>>
>>>   1.) It assumes all devices sharing an SMMU have the same number of
>>>       "smmu cells"
>>
>> This can be solved with introducing the fixed size of bitmap. The size
>> of bitmap can be fixed even per SoC. In tegra we used 64(2 cells)
>> which I expect at most.
> 
> That really doesn't sound like a good idea where you have bridges (like a
> PCIe host controller) which could have a significant chunk of StreamID
> space. You'd also need to pad everything out with some dummy IDs for parsing
> purposes. Yuck!

Can't you solve this by having the SMMU include a stream ID mapping
table. In the case of stream IDs having a large "address" space, then
just define the mapping table syntax to allow easy specification of
ranges using start/length, start/end, or value/mask pairs. Similar to
ranges or PCI's interrupt-map{,-mask}.
