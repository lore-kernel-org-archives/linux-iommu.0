From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5] devicetree: Add generic IOMMU device tree bindings
Date: Tue, 19 Aug 2014 13:03:52 +0300
Message-ID: <87zjf0hk3b.fsf@nvidia.com>
References: <1406803383-11601-1-git-send-email-thierry.reding@gmail.com>
	<87a9774lf5.fsf@nvidia.com>
	<cfb1d2ff66004685b7ead3f5e6321681@BL2PR03MB468.namprd03.prod.outlook.com>
	<87y4ur2h23.fsf@nvidia.com>
	<d9fb045d54244f26a773ba45ad3caa2d@BL2PR03MB468.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <d9fb045d54244f26a773ba45ad3caa2d-AZ66ij2kwaacCcN9WK45f+O6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org> writes:

> Hi Hiroshi,
>
>> -----Original Message-----
>> From: Hiroshi Doyu [mailto:hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org]
>> Sent: Thursday, August 14, 2014 9:35 PM
>> To: Sethi Varun-B16395
>> Cc: Hiroshi Doyu; Thierry Reding; Stephen Warren; Arnd Bergmann; Will
>> Deacon; Mark Rutland; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Olof Johansson;
>> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Rob Herring; linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
>> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>> Subject: Re: [PATCH v5] devicetree: Add generic IOMMU device tree bindings
>> 
>> Hi Varun,
>> 
>> Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org> writes:
>> 
>> >> -----Original Message-----
>> >> From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
>> >> bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Hiroshi Doyu
>> >> Sent: Thursday, August 14, 2014 12:18 PM
>> >> To: Thierry Reding; Stephen Warren; Arnd Bergmann; Will Deacon
>> >> Cc: Mark Rutland; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Olof Johansson;
>> >> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Rob Herring;
>> >> linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>> >> Subject: Re: [PATCH v5] devicetree: Add generic IOMMU device tree
>> >> bindings
>> >>
>> >>
>> >> Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>> >>
>> >> > +Multiple-master IOMMU:
>> >> > +----------------------
>> >> > +
>> >> > +       iommu {
>> >> > +               /* the specifier represents the ID of the master */
>> >> > +               #iommu-cells = <1>;
>> >> > +       };
>> >> > +
>> >> > +       master@1 {
>> >> > +               /* device has master ID 42 in the IOMMU */
>> >> > +               iommus = <&{/iommu} 42>;
>> >> > +       };
>> >> > +
>> >> > +       master@2 {
>> >> > +               /* device has master IDs 23 and 24 in the IOMMU */
>> >> > +               iommus = <&{/iommu} 23>, <&{/iommu} 24>;
>> >> > +       };
>> >>
>> >> I think that this "master ID" will be parsed in IOMMU driver. For
>> >> example, ARM,SMMU expects "streamID" as "master ID", right?
>> >>
>> >> If a SoC has a feature to configure to assign streamID to devices at
>> >> runtime, "streamID" is not equal to "master ID".
>> >>
>> >>   iommus = <&{/smmu} "soc specific master ID">;
>> >>
>> >> "soc master ID" needs to be translated into "streamID" by SoC SW. It
>> >> seems that ARM,SMMU kernel driver doesn't expect this kind of ID
>> >> translation. If ARM,SMMU kernel driver is used as is, "soc master ID"
>> >> would be incompatible? ARM,SMMU needs such translation before
>> >> parsing. Is this my understanding right?
>> >>
>> >> If so I think that this master ID configuration/translation may be
>> >> quite reasonable requirment for SoC using ARM,SMMU.
>> >>
>> >> Can we consider this ID translation within ARM,SMMU compatibility?
>> >>
>> >> IOW, is it possible to implement some SoC specific hook for ID
>> >> translation/configuration in ARM,SMMU kernel driver?
>> >
>> >
>> > Can the id translation be done using a SMR mask?
>> 
>> No, "SoC master ID" is completely independenf of SMR.
>> 
>> > Also, for dynamic stream ID allocation we would need to represent the
>> > specific master register (to store the stream ID) in the device tree.
>> 
>> I assmue that the above means that iMX has such configuration register to map
>> steramID and a device dynamically.
>
> We have per master registers for setting the stream ID on the
> Layerscape platforms. My point was that we would need the iommu master
> node to include a reference to the master id register.
>
> master@1 {
>                /* device has master ID 42 in the IOMMU */
>              iommus = <&{/iommu} 42>;
>              master-id-reg = <phandle offset>
> };

In the above, for "iommus=" bindings, you wouldn't need to break
ARM,SMMU compatibility at all if you set "streamID" exactly as below.

  master@1 {
                 /* device has master ID 42 in the IOMMU */
               iommus = <&{/iommu} 'any given streamID'>;
               master-id-reg = <phandle offset>
  };

And your SoC needs to register bus_notifier and ADD_DEVICE should
configure to map 'any given streamID' to a device via the above
register. This wouldn't need any modification from ARM,SMMU driver and
keep the iommus bindings as it is.

IOW, SoC only needs to register ADD_DEVICE in bus_notifier to map
StreamID to a device. This needs to be executed earlier than IOMMU bus's
ADD_DEVICE, though.

Is my understanding right?
