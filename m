From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: Re: What differences and relations between SVM, HSA, HMM and Unified
 Memory?
Date: Tue, 18 Jul 2017 08:15:39 +0800
Message-ID: <b83c3d3c-1bcd-3ecc-bf61-b9e0b52e6786@huawei.com>
References: <9BD73EA91F8E404F851CF3F519B14AA8CE753F@SZXEMI503-MBS.china.huawei.com>
 <20c9cdd5-5118-f916-d8ad-70b7c1434d73@arm.com>
 <1c4f4fb0-7201-ed4c-aa88-4d7e2369238e@huawei.com>
 <20170717142743.GA9420@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170717142743.GA9420@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Glisse <j.glisse@gmail.com>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Wuzongyong (Cordius Wu, Euler Dept)" <wuzongyong1@huawei.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wanzongshun (Vincent)" <wanzongshun@huawei.com>, "oded.gabbay@amd.com" <oded.gabbay@amd.com>, liubo95@huawei.com
List-Id: iommu@lists.linux-foundation.org

Hi Jérôme and Jean-Philippe ,

Get it, thanks for all of your detail explain.

Thanks
Yisheng Xie

On 2017/7/17 22:27, Jerome Glisse wrote:
> On Mon, Jul 17, 2017 at 07:57:23PM +0800, Yisheng Xie wrote:
>> Hi Jean-Philippe，
>>
>> On 2017/6/12 19:37, Jean-Philippe Brucker wrote:
>>> Hello,
>>>
>>> On 10/06/17 05:06, Wuzongyong (Cordius Wu, Euler Dept) wrote:
>>>> Hi,
>>>>
>>>> Could someone explain differences and relations between the SVM(Shared
>>>> Virtual Memory, by Intel), HSA(Heterogeneous System Architecture, by AMD),
>>>> HMM(Heterogeneous Memory Management, by Glisse) and UM(Unified Memory, by
>>>> NVIDIA) ? Are these in the substitutional relation?
>>>>
>>>> As I understand it, these aim to solve the same thing, sharing pointers
>>>> between CPU and GPU(implement with ATS/PASID/PRI/IOMMU support). So far,
>>>> SVM and HSA can only be used by integrated gpu. And, Intel declare that
>>>> the root ports doesn’t not have the required TLP prefix support, resulting
>>>>  that SVM can’t be used by discrete devices. So could someone tell me the
>>>> required TLP prefix means what specifically?>
>>>> With HMM, we can use allocator like malloc to manage host and device
>>>> memory. Does this mean that there is no need to use SVM and HSA with HMM,
>>>> or HMM is the basis of SVM and HAS to implement Fine-Grained system SVM
>>>> defined in the opencl spec?
>>>
>>> I can't provide an exhaustive answer, but I have done some work on SVM.
>>> Take it with a grain of salt though, I am not an expert.
>>>
>>> * HSA is an architecture that provides a common programming model for CPUs
>>> and accelerators (GPGPUs etc). It does have SVM requirement (I/O page
>>> faults, PASID and compatible address spaces), though it's only a small
>>> part of it.
>>>
>>> * Similarly, OpenCL provides an API for dealing with accelerators. OpenCL
>>> 2.0 introduced the concept of Fine-Grained System SVM, which allows to
>>> pass userspace pointers to devices. It is just one flavor of SVM, they
>>> also have coarse-grained and non-system. But they might have coined the
>>> name, and I believe that in the context of Linux IOMMU, when we talk about
>>> "SVM" it is OpenCL's fine-grained system SVM.
>>> [...]
>>>
>>> While SVM is only about virtual address space,
>> As you mentioned, SVM is only about virtual address space, I'd like to know how to
>> manage the physical address especially about device's RAM, before HMM?
>>
>> When OpenCL alloc a SVM pointer like:
>>     void* p = clSVMAlloc (
>>         context, // an OpenCL context where this buffer is available
>>         CL_MEM_READ_WRITE | CL_MEM_SVM_FINE_GRAIN_BUFFER,
>>         size, // amount of memory to allocate (in bytes)
>>         0 // alignment in bytes (0 means default)
>>     );
>>
>> where this RAM come from， device RAM or host RAM?
>>
> 
> For SVM using ATS/PASID with FINE_GRAIN your allocation can only
> be inside the system memory (host RAM). You need a special system
> bus like CAPI or CCIX which both are step further than ATS/PASID
> to be able to allow fine grain to use device memory.
> 
> However that is where HMM can be usefull as HMM is a software
> solution to this problem. So with HMM and a device that can work
> with HMM, you can get fine grain allocation to also use device
> memory however any CPU access will happen in host RAM.
> 
> Jérôme
> 
> .
> 
