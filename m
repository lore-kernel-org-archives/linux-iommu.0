From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
Date: Fri, 30 May 2014 22:29:13 +0300
Message-ID: <87tx87rrp2.fsf@nvidia.com>
References: <1400877218-4113-1-git-send-email-thierry.reding@gmail.com>
	<CAL_JsqKumG1PSFoVfeGpLLG+MjXFeF4aUjun=vv1BJpaxk0Byg@mail.gmail.com>
	<4545972.cM7IP1qTXQ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4545972.cM7IP1qTXQ@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> writes:

>> > +Multiple-master IOMMU:
>> > +----------------------
>> > +
>> > +       iommu {
>> > +               /* the specifier represents the ID of the master */
>> > +               #address-cells = <1>;
>> > +               #size-cells = <0>;
>> > +       };
>> > +
>> > +       master {
>> > +               /* device has master ID 42 in the IOMMU */
>> > +               iommus = <&/iommu 42>;
>> > +       };
>> 
>> Presumably the ID would be the streamID on ARM's SMMU. How would a
>> master with 8 streamIDs be described? This is what Calxeda midway has
>> for SATA and I would expect that to be somewhat common. Either you
>> need some ID masking or you'll have lots of duplication when you have
>> windows.
>
> I don't understand the problem. If you have stream IDs 0 through 7,
> you would have
>
> 	master@a {
> 		...
> 		iommus = <&smmu 0>;
> 	};
>
> 	master@b {
> 		...
> 		iommus = <&smmu 1;
> 	};
>
> 	...
>
> 	master@12 {
> 		...
> 		iommus = <&smmu 7;
> 	};
>
> and you don't need a window at all. Why would you need a mask of
> some sort?

IIUC the original problem, "a master with 8 streamIDs" means something
like below, where some devices have multiple IDs but some have a
single. A sinle #address-cells cannot afford those 2 masters at once.

       iommu {
               /* the specifier represents the ID of the master */
               #address-cells = <1>;
               #size-cells = <0>;
       };

 	master@a {
 		...
 		iommus = <&smmu 1 2 3>; # 3 IDs
 	};

 	master@b {
 		...
 		iommus = <&smmu 4>;     # 1 ID
 	};

Tegra,SMMU has a similar problem and we have used a fixed size bitmap(64
bit) to afford 64 stream IDs so that a single device can hold multiple
IDs. If we apply the same bitmap to the above exmaple:

       iommu {
               /* the specifier represents the ID of the master */
               #address-cells = <1>;
               #size-cells = <0>;
       };

 	master@a {
 		...
 		iommus = <&smmu (BIT(1) | BIT(2) | BIT(3))>; # IDs 1 2 3
 	};

 	master@b {
 		...
 		iommus = <&smmu BIT(4)>;     # ID 4
 	};

The disadvantage of this is that this limits the max number of streamIDs
to support. If # of streamID is increased later more than 64, this
format cannot cover any more. You have to predict the max # of streamIDs
in advance if steamID is statically assigned.
