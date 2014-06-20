From: Shannon Zhao <zhaoshenglong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: Vfio-on-arm: the device tree does not contain the DMA device
Date: Fri, 20 Jun 2014 10:57:25 +0800
Message-ID: <53A3A315.4010409@huawei.com>
References: <53A0FA5D.5090204@huawei.com>
	<53A192FE.2070303@virtualopensystems.com>
	<53A2AA0E.3060207@huawei.com>
	<a96a278c8fd04586b8120c48b78cb963@BLUPR03MB566.namprd03.prod.outlook.com>
	<53A2AF80.5080705@huawei.com>
	<53A2BFAA.2050507@virtualopensystems.com>
	<53A2C57A.9050504@huawei.com>
	<53A2C8D5.4070801@virtualopensystems.com>
	<53A2D2B2.2040902@huawei.com>
	<cf15be43f0964293a969c5a93f3c5d54@BLUPR03MB566.namprd03.prod.outlook.com>
	<53A2D4A2.9070600@huawei.com>
	<a6fcdaa299594393a4274ed44d49ae46@BLUPR03MB566.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <a6fcdaa299594393a4274ed44d49ae46-GeMU99Gfrru4FpqPz9FowuO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alvise Rigo <a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org" <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Bharat,

Thanks for your advice .

I'm using the rootfs getting from the url "http://www.virtualopensystems.com/downloads/guides/kvm_on_arm/fs-alip-armel.cramfs".

Can you give me another link to get a newer rootfs?

Thank you
Shannon

On 2014/6/19 20:20, Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org wrote:
> 
> 
>> -----Original Message-----
>> From: Shannon Zhao [mailto:zhaoshenglong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org]
>> Sent: Thursday, June 19, 2014 5:47 PM
>> To: Bhushan Bharat-R65777; Alvise Rigo; a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org;
>> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org
>> Subject: Re: Vfio-on-arm: the device tree does not contain the DMA device
>>
>>
>>
>> On 2014/6/19 20:12, Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Shannon Zhao [mailto:zhaoshenglong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org]
>>>> Sent: Thursday, June 19, 2014 5:38 PM
>>>> To: Alvise Rigo; Bhushan Bharat-R65777;
>>>> a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
>>>> kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org
>>>> Subject: Re: Vfio-on-arm: the device tree does not contain the DMA
>>>> device
>>>>
>>>> Hi Alvise,
>>>>
>>>> I run following cmds :
>>>> 	echo 2c0a0000.dma >
>>>> /sys/bus/platform/drivers/vfio-platform/vfio_bind
>>>
>>> run "ls /dev/vfio/" before and after the above command
>> Hi Bharat,
>>
>> Nothing appeared either before or after the cmd "echo 2c0a0000.dma >
>> /sys/bus/platform/drivers/vfio-platform/vfio_bind".
>> There is only /dev/vfio.
> 
> I am not sure, but may be you are using pretty old rootfs with broken udev rules. Try to fetch a newer rootfs form somewhere.
> 
> Thanks
> -Bharat
> 
> 
>>>
>>> Thanks
>>> -Bharat
>>>
>>>
>>>> 	./qemu-system-arm -enable-kvm -M vexpress-a15 -cpu cortex-a15 \
>>>>         	-device
>>>>
>> pl330,vfio_group="/dev/vfio/0",vfio_device="2c0a0000.dma",vfio_container="/dev/v
>>>> fio/vfio" \
>>>>         	-append "earlyprintk ip=dhcp console=ttyAMA0 rootwait" \
>>>>         	-kernel zImage -dtb guest-a15.dtb -initrd filesystem.cpio.gz  -
>>>> nographic But the error still exists.
>>>> 	qemu-system-arm: -device
>>>>
>> pl330,vfio_group=/dev/vfio/0,vfio_device=2c0a0000.dma,vfio_container=/dev/vfio/v
>>>> fio: Parameter 'driver' expects pluggable device type
>>>>
>>>> Thanks,
>>>> Shannon
>>>>
>>>> On 2014/6/19 19:26, Alvise Rigo wrote:
>>>>>
>>>>>
>>>>> Il 19/06/2014 13:11, Shannon Zhao ha scritto:
>>>>>>
>>>>>>
>>>>>> On 2014/6/19 18:47, Alvise Rigo wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> Il 19/06/2014 11:38, Shannon Zhao ha scritto:
>>>>>>>> Hi Bharat,
>>>>>>>>
>>>>>>>> On 2014/6/19 17:19, Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> -----Original Message-----
>>>>>>>>>> From: kvmarm-bounces-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org [mailto:kvmarm-
>>>>>>>>>> bounces-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org] On Behalf Of Shannon Zhao
>>>>>>>>>> Sent: Thursday, June 19, 2014 2:45 PM
>>>>>>>>>> To: Alvise Rigo; a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org;
>>>>>>>>>> iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org foundation.org; kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org
>>>>>>>>>> Subject: Re: Vfio-on-arm: the device tree does not contain the
>>>>>>>>>> DMA device
>>>>>>>>>>
>>>>>>>>>> Hi Alvise,
>>>>>>>>>>
>>>>>>>>>> Thanks for your reply.
>>>>>>>>>> I have apply the patch and could see the DMA devices.
>>>>>>>>>> But there is no vosys_dmatest int the directory
>>>>>>>>>> "/sys/kernel/debug/" after mounting debugfs.
>>>>>>>>>> I found that the branch vfio-platform-v4 doesn't contain the
>>>>>>>>>> module vosys_dmatest.
>>>>>>>>>> Then I port it from the branch pl330_dmatest and run vosys_dmatest
>>>> successfully.
>>>>>>>>>>
>>>>>>>>>> 	echo 1 > /sys/kernel/debug/vosys_dmatest/start
>>>>>>>>>>
>>>>>>>>>> 	[ 6145.343419] dmaengine: __dma_request_channel: success
>>>> (dma0chan0)
>>>>>>>>>> 	[ 6145.344000] vosys dmatest: callback: transfer completed
>>>>>>>>>> 	[ 6145.344147] vosys dmatest: tx completed
>>>>>>>>>> 	[ 6145.344589] vosys dmatest: source and destination match.
>>>>>>>>>>
>>>>>>>>>> Download the qemu and use following command to start a guest:
>>>>>>>>>> 	./qemu-system-arm -enable-kvm -M vexpress-a15 -cpu cortex-a15 \
>>>>>>>>>>         	-device
>>>> pl330,vfio_group="/dev/vfio/0",vfio_device="2c0a0000.dma",\
>>>>>>>>>>         	vfio_container="/dev/vfio/vfio" \
>>>>>>>>>>         	-append "earlyprintk ip=dhcp console=ttyAMA0 rootwait" \
>>>>>>>>>>         	-kernel zImage -dtb guest.dtb -initrd filesystem.cpio.gz
>>>>>>>>>> - nographic An error reported:
>>>>>>>>>> 	qemu-system-arm: -device
>>>>>>>>>> pl330,vfio_group=/dev/vfio/0,vfio_device=2c0a0000.dma,:
>>>>>>>>>
>>>>>>>>> Why do we need to give "vfio_group=/dev/vfio/0" ?
>>>>>>>> I refer to the url
>>>> "http://www.virtualopensystems.com/en/solutions/guides/vfio-on-arm/".
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> 	could not open disk image vfio_container=/dev/vfio:
>>>>>>>>>> 	Could not open 'vfio_container=/dev/vfio': No such file or
>>>>>>>>>> directory
>>>>>>>>>
>>>>>>>>> Are you unbinding "2c0a0000.dma" from its driver and binding with "vfio-
>>>> playform" driver ?
>>>>>>>> How to unbind "2c0a0000.dma" from its driver?
>>>>>>>> I have tried following cmd to bind "2c0a0000.dma" with "vfio-playform"
>>>> driver.
>>>>>>>> 	echo 2c0a0000.dma >
>>>>>>>> /sys/bus/platform/drivers/vfio-platform/vfio_bind
>>>>>>>> But there is no /dev/vfio/0 or /dev/vfio/vfio .
>>>>>>>
>>>>>>>
>>>>>>> Can you please verify that while configuring the host you enabled:
>>>>>>> - Device Drivers -> IOMMU Hardware Support -> ARM Ltd. System MMU
>>>>>>> (SMMU) Support and
>>>>>>> - Device Drivers -> VFIO Non-Privileged userspace driver framework
>>>>>>> -> VFIO support for platform devices
>>>>>>>
>>>>>> Hi Alvise,
>>>>>>
>>>>>> I have checked the two configuration are enabled.
>>>>>>
>>>>>> Then try the following cmd, but another error reported:
>>>>>> 	qemu-system-arm: -device
>>>>>> pl330,vfio_group=/dev/vfio/0,vfio_device=2c0a0000.dma,vfio_container=
>>>>>> /dev/vfio/vfio: Parameter 'driver' expects pluggable device type
>>>>>>
>>>>>> Do I need to unbind the "2c0a0000.dma" from its driver and binding with
>>>> "vfio-platform" driver as Bharat mentioned ?
>>>>>
>>>>> Yes, the 2c0a0000.dma should not be bound to any driver at boot, so
>>>>> you just need to:
>>>>> echo 2c0a0000.dma > /sys/bus/platform/drivers/vfio-platform/vfio_bind
>>>>> to bind the device to the VFIO driver.
>>>>
>>>>>
>>>>> Regards,
>>>>> alvise
>>>>>
>>>>>>
>>>>>>> Then try to update the pl330-vfio-dev branch and run QEMU with the
>> following
>>>> command:
>>>>>>>
>>>>>>> ./qemu-system-arm -enable-kvm -M vexpress-a15 -cpu cortex-a15 \
>>>>>>>     -device
>>>>
>> pl330,vfio_group="/dev/vfio/0",vfio_device="2c0a0000.dma",vfio_container="/dev/v
>>>> fio/vfio" \
>>>>>>>     -append "earlyprintk ip=dhcp console=ttyAMA0 rootwait" \
>>>>>>>     -kernel zImage -dtb guest.dtb -initrd filesystem.cpio.gz
>>>>>>>
>>>>>>> that means without breaking the "-device pl330" options.
>>>>>>>
>>>>>>> Regards,
>>>>>>> alvise
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Thanks
>>>>>>>>> -Bharat
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Is there something I'm wrong or do I miss some steps?
>>>>>>>>>>
>>>>>>>>>> Thank you,
>>>>>>>>>> Shannon
>>>>>>>>>>
>>>>>>>>>> On 2014/6/18 21:24, Alvise Rigo wrote:
>>>>>>>>>>> Hi Shannon,
>>>>>>>>>>>
>>>>>>>>>>> Thank you for reporting this issue, the device tree file was indeed
>>>> missing.
>>>>>>>>>>> To solve the problem, you can apply the following patch to the
>>>>>>>>>>> repository you mentioned
>>>>>>>>>>> (git://github.com/virtualopensystems/arm-dts.git).
>>>>>>>>>>>
>>>>>>>>>>> For your information, soon we will update the guide with a newer
>>>>>>>>>>> version of VFIO with this issue fixed.
>>>>>>>>>>>
>>>>>>>>>>> Thank you,
>>>>>>>>>>> alvise
>>>>>>>>>>>
>>>>>>>>>>> ---
>>>>>>>>>>>  fast_models/rtsm_ve-cortex_a15x4_a7x4.dts | 100
>>>>>>>>>>> +++++++++++++++++++++++++++++-
>>>>>>>>>>>  1 file changed, 97 insertions(+), 3 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/fast_models/rtsm_ve-cortex_a15x4_a7x4.dts
>>>>>>>>>>> b/fast_models/rtsm_ve-cortex_a15x4_a7x4.dts
>>>>>>>>>>> index ef1275b..79c6af2 100644
>>>>>>>>>>> --- a/fast_models/rtsm_ve-cortex_a15x4_a7x4.dts
>>>>>>>>>>> +++ b/fast_models/rtsm_ve-cortex_a15x4_a7x4.dts
>>>>>>>>>>> @@ -142,7 +142,7 @@
>>>>>>>>>>>  		cpu7: cpu@7 {
>>>>>>>>>>>  			device_type = "cpu";
>>>>>>>>>>>  			compatible = "arm,cortex-a7";
>>>>>>>>>>> -			reg = <0x104>;
>>>>>>>>>>> +			reg = <0x103>;
>>>>>>>>>>>  			cluster = <&cluster1>;
>>>>>>>>>>>  			core = <&core7>;
>>>>>>>>>>>  		};
>>>>>>>>>>> @@ -159,7 +159,7 @@
>>>>>>>>>>>  		#address-cells = <0>;
>>>>>>>>>>>  		interrupt-controller;
>>>>>>>>>>>  		reg = <0 0x2c001000 0 0x1000>,
>>>>>>>>>>> -		      <0 0x2c002000 0 0x2000>,
>>>>>>>>>>> +		      <0 0x2c002000 0 0x1000>,
>>>>>>>>>>>  		      <0 0x2c004000 0 0x2000>,
>>>>>>>>>>>  		      <0 0x2c006000 0 0x2000>;
>>>>>>>>>>>  		interrupts = <1 9 0xf04>;
>>>>>>>>>>> @@ -183,6 +183,101 @@
>>>>>>>>>>>  			     <1 10 0xf08>;
>>>>>>>>>>>  	};
>>>>>>>>>>>
>>>>>>>>>>> +	smmu@2c0b0000 {
>>>>>>>>>>> +                compatible = "arm,smmu-v2";
>>>>>>>>>>> +                reg = <0x0 0x2c0b0000 0x0 0x10000>;
>>>>>>>>>>> +                #global-interrupts = <2>;
>>>>>>>>>>> +                interrupts = <0 58 4>,
>>>>>>>>>>> +                             <0 59 4>,
>>>>>>>>>>> +                             <0 60 4>,
>>>>>>>>>>> +                             <0 60 4>,
>>>>>>>>>>> +                             <0 60 4>,
>>>>>>>>>>> +                             <0 60 4>,
>>>>>>>>>>> +                             <0 60 4>,
>>>>>>>>>>> +                             <0 60 4>,
>>>>>>>>>>> +                             <0 60 4>;
>>>>>>>>>>> +                mmu-masters = <&dma0 0x0 0x8>,
>>>>>>>>>>> +                              <&dma1 0x1 0x9>,
>>>>>>>>>>> +                              <&dma2 0x2 0xa>,
>>>>>>>>>>> +                              <&dma3 0x3 0xb>;
>>>>>>>>>>> +        };
>>>>>>>>>>> +
>>>>>>>>>>> +	dma0: dma@2c0a0000 {
>>>>>>>>>>> +		compatible = "arm,pl330";
>>>>>>>>>>> +		reg = <0 0x2c0a0000 0 0x1000>;
>>>>>>>>>>> +		interrupts = <0 64 4>,
>>>>>>>>>>> +			     <0 65 4>,
>>>>>>>>>>> +			     <0 66 4>,
>>>>>>>>>>> +			     <0 67 4>,
>>>>>>>>>>> +			     <0 68 4>,
>>>>>>>>>>> +			     <0 69 4>,
>>>>>>>>>>> +			     <0 70 4>,
>>>>>>>>>>> +			     <0 71 4>;
>>>>>>>>>>> +		#dma-cells = <1>;
>>>>>>>>>>> +		#stream-id-cells = <2>;
>>>>>>>>>>> +		clocks = <&oscclk6a>;
>>>>>>>>>>> +		clock-names = "apb_pclk";
>>>>>>>>>>> +	};
>>>>>>>>>>> +
>>>>>>>>>>> +	dma1: dma@2c0a1000 {
>>>>>>>>>>> +		compatible = "arm,pl330", "arm,primecell";
>>>>>>>>>>> +		reg = <0 0x2c0a1000 0 0x1000>;
>>>>>>>>>>> +		interrupts = <0 96 4>,
>>>>>>>>>>> +			     <0 97 4>,
>>>>>>>>>>> +			     <0 98 4>,
>>>>>>>>>>> +			     <0 99 4>,
>>>>>>>>>>> +			     <0 100 4>,
>>>>>>>>>>> +			     <0 101 4>,
>>>>>>>>>>> +			     <0 102 4>,
>>>>>>>>>>> +			     <0 103 4>;
>>>>>>>>>>> +		#dma-cells = <1>;
>>>>>>>>>>> +		#stream-id-cells = <2>;
>>>>>>>>>>> +		clocks = <&oscclk6a>;
>>>>>>>>>>> +		clock-names = "apb_pclk";
>>>>>>>>>>> +	};
>>>>>>>>>>> +
>>>>>>>>>>> +	dma2: dma@2c0a2000 {
>>>>>>>>>>> +		compatible = "arm,pl330", "arm,primecell";
>>>>>>>>>>> +		reg = <0 0x2c0a2000 0 0x1000>;
>>>>>>>>>>> +		interrupts = <0 128 4>,
>>>>>>>>>>> +			     <0 129 4>,
>>>>>>>>>>> +			     <0 130 4>,
>>>>>>>>>>> +			     <0 131 4>,
>>>>>>>>>>> +			     <0 132 4>,
>>>>>>>>>>> +			     <0 133 4>,
>>>>>>>>>>> +			     <0 134 4>,
>>>>>>>>>>> +			     <0 135 4>;
>>>>>>>>>>> +		#dma-cells = <1>;
>>>>>>>>>>> +		#stream-id-cells = <2>;
>>>>>>>>>>> +		clocks = <&oscclk6a>;
>>>>>>>>>>> +		clock-names = "apb_pclk";
>>>>>>>>>>> +	};
>>>>>>>>>>> +
>>>>>>>>>>> +	dma3: dma@2c0a3000 {
>>>>>>>>>>> +		compatible = "arm,pl330", "arm,primecell";
>>>>>>>>>>> +		reg = <0 0x2c0a3000 0 0x1000>;
>>>>>>>>>>> +		interrupts = <0 160 4>,
>>>>>>>>>>> +			     <0 161 4>,
>>>>>>>>>>> +			     <0 162 4>,
>>>>>>>>>>> +			     <0 163 4>,
>>>>>>>>>>> +			     <0 164 4>,
>>>>>>>>>>> +			     <0 165 4>,
>>>>>>>>>>> +			     <0 166 4>,
>>>>>>>>>>> +			     <0 167 4>;
>>>>>>>>>>> +		#dma-cells = <1>;
>>>>>>>>>>> +		#stream-id-cells = <2>;
>>>>>>>>>>> +		clocks = <&oscclk6a>;
>>>>>>>>>>> +		clock-names = "apb_pclk";
>>>>>>>>>>> +	};
>>>>>>>>>>> +
>>>>>>>>>>> +	oscclk6a: oscclk6a {
>>>>>>>>>>> +		/* Reference 24MHz clock */
>>>>>>>>>>> +		compatible = "fixed-clock";
>>>>>>>>>>> +		#clock-cells = <0>;
>>>>>>>>>>> +		clock-frequency = <24000000>;
>>>>>>>>>>> +		clock-output-names = "oscclk6a";
>>>>>>>>>>> +	};
>>>>>>>>>>> +
>>>>>>>>>>>  	smb {
>>>>>>>>>>>  		compatible = "simple-bus";
>>>>>>>>>>>
>>>>>>>>>>> @@ -244,4 +339,3 @@
>>>>>>>>>>>  		/include/ "rtsm_ve-motherboard.dtsi"
>>>>>>>>>>>  	};
>>>>>>>>>>>  };
>>>>>>>>>>> -
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> --
>>>>>>>>>> Shannon
>>>>>>>>>>
>>>>>>>>>> _______________________________________________
>>>>>>>>>> kvmarm mailing list
>>>>>>>>>> kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org
>>>>>>>>>> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
>>>>>>>>>
>>>>>>>>> .
>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>> .
>>>>>>>
>>>>>>
>>>>>
>>>>> .
>>>>>
>>>>
>>>> --
>>>> Shannon
>>>
>>>
>>> .
>>>
>>
>> --
>> Shannon
> 
> 
> .
> 

-- 
Shannon
