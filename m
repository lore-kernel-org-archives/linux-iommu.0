From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: Re: [RFCv2 PATCH 05/36] iommu/process: Bind and unbind process to and
 from devices
Date: Thu, 30 Nov 2017 09:11:58 +0800
Message-ID: <7ba3d70a-2364-2a92-39a8-ed112807b83c@huawei.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-6-jean-philippe.brucker@arm.com>
 <9c364147-12c4-5a8a-9cd9-0642a6b92555@huawei.com>
 <3338635f-f2ba-4b78-a72b-2568645f7df3@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <3338635f-f2ba-4b78-a72b-2568645f7df3@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, Robin Murphy <Robin.Murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "tn@semihalf.com" <tn@semihalf.com>, "liubo95@huawei.com" <liubo95@huawei.com>, "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>, "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>, nwatters@c
List-Id: iommu@lists.linux-foundation.org

Hi, Jean,

On 2017/11/29 23:01, Jean-Philippe Brucker wrote:
> On 29/11/17 06:08, Yisheng Xie wrote:
>>
>>
>> On 2017/10/6 21:31, Jean-Philippe Brucker wrote:
>>> +int iommu_process_bind_device(struct device *dev, struct task_struct *task,
>>> +			      int *pasid, int flags)
>>> +{
>> [..]
>>> +			err = iommu_process_attach_locked(context, dev);
>>> +			if (err)
>>> +				iommu_process_put_locked(process);
>> one ref for a context is enough right? so also need call iommu_process_put_locked()
>> if attach ok, or will be leak if user call bind twice for the same device and task.
> 
> I wasn't sure, I think I prefer taking one ref for each bind. If user
> calls bind twice, it should call unbind twice as well (in case of leak we
> free the context on process exit).
> 
> Also with this implementation, user can call bind for two devices in the
> same domain, which will share the same context structure. So we have to
> take as many refs as bind() calls.


hmm, it has two ref, one for _context_ and the other for *process* (or maybe mm for
your next version), right? For each bind it will take a ref of context as present
design. but why also process ref need be taken for each bind? I mean it seems does
not break _user can call bind for two devices in the same domain_.

And if you really want to take a ref of *process* for echo bind, you should put it when
unbind, right? I just not find where you put the ref of process when unbind. But just put
the process ref when free context.

Maybe I just miss something.

Thanks
Yisheng Xie
> 
> Thanks,
> Jean
> 
> .
> 

