From: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC Design Doc v3] Enable Shared Virtual Memory feature in
	pass-through scenarios
Date: Wed, 30 Nov 2016 08:49:24 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257436DE3165@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>
Cc: "Lan, Tianyu" <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Peng, Chao P" <chao.p.peng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Hao,
	Xudong" <xudong.hao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Sun, Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, 'Peter Xu' <peterx-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Pan, Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

What's changed from v2:
a) Detailed feature description
b) refine description in "Address translation in virtual SVM"
b) "Terms" is added

Content
===============================================
1. Feature description
2. Why use it?
3. How to enable it
4. How to test
5. Terms

Details
===============================================
1. Feature description
Shared virtual memory(SVM) is to let application program share its virtual
address with SVM capable devices. 

Shared virtual memory details:
a) SVM feature requires ATS/PRQ/PASID support on both device side and
IOMMU side.
b) SVM capable devices could send DMA requests with PASID, the address
in the request would be a virtual address within a program's virtual address
space.
c) IOMMU would use first level page table to translate the address in the
request.
d) First level page table is a HVA->HPA mapping on bare metal.

Shared Virtual Memory feature in pass-through scenarios is actually SVM
virtualization. It is to let application programs(running in guest)share their
virtual address with assigned device(e.g. graphics processors or accelerators).

In virtualization, SVM would be:
a) Require a vIOMMU exposed to guest
b) Assigned SVM capable device could send DMA requests with PASID, the
address in the request would be a virtual address within a guest
program's virtual address space(GVA).
c) Physical IOMMU needs to do GVA->GPA->HPA translation. Nested mode
would be enabled, first level page table would achieve GVA->GPA mapping,
while second level page table would achieve GPA->HPA translation.

For more SVM detail, you may want refer to section 2.5.1.1 of Intel VT-d spec
and section 5.6 of OpenCL spec. For details about SVM address translation,
pls refer to section 3 of Intel VT-d spec.
It's also welcomed to discuss directly in this thread.

Link to related specs:
http://www.intel.com/content/dam/www/public/us/en/documents/product-specifications/vt-directed-io-spec.pdf
https://www.khronos.org/registry/cl/specs/opencl-2.0.pdf


2. Why use it?
It is common to pass-through devices to guest and expect to achieve as
much similar performance as it is on host. With this feature enabled, 
the application programs in guest would be able to share data-structures
with assigned devices without unnecessary overheads.


3. How to enable it
As mentioned above, SVM virtualization requires a vIOMMU exposed to guest.
Since there is an existing IOMMU emulator in host user space(QEMU), it is
more acceptable to extend the IOMMU emulator to support SVM for assigned
devices. So far, the vIOMMU exposed to guest is only for emulated devices.
In this design, it would focus on virtual SVM for assigned devices. Virtual
IOVA and virtual interrupt remapping will not be included here.

The enabling work would include the following items.

a) IOMMU Register Access Emulation
Already existed in QEMU, need some extensions to support SVM. e.g. support
page request service related registers(PQA_REG).

b) vIOMMU Capability
Report SVM related capabilities(PASID,PRS,DT,PT,ECS etc.) in ex-capability
register and cache mode, DWD, DRD in capability register.

c) QI Handling Emulation
Already existed in QEMU, need to shadow the QIs related to assigned devices to
physical IOMMU.
i.	ex-context entry cache invalidation(nested mode setting, guest PASID table
pointer shadowing)
ii.	1st level translation cache invalidation
iii.	Response for recoverable faults

d) Address translation in virtual SVM
In virtualization, for requests with PASID from assigned device, the address translation
would be subjected to first level page table and then second level page table, which is
named nested mode. Extended context mode should be supported on hardware. DMA
remapping in SVM virtualization would be:
i.	For requests with PASID, the related extended context entry should have
the NESTE bit set. 
ii.	Guest PASID table pointer should be shadowed to host IOMMU driver.
The PASID table pointer field in extended context entry would be a GPA as
nested mode is on.

First level page table would be maintained by guest IOMMU driver. Second level
page table would be maintained by host IOMMU driver.

e) Recoverable Address Translation Faults Handling Emulation
It is serviced by page request when device support PRS. For assigned devices, 
host IOMMU driver would get page requests from pIOMMU. Here, we need a
mechanism to drain the page requests from devices which are assigned to a
guest. In this design it would be done through VFIO. Page request descriptors
would be propagated to user space and then exposed to guest IOMMU driver.
This requires following support:
i.	a mechanism to notify vIOMMU emulator to fetch PRQ descriptor
ii.	a notify framework in QEMU to signal the PRQ descriptor fetching when
notified by pIOMMU

f) Non-Recoverable Address Translation Handling Emulation
The non-recoverable fault propagation is similar to recoverable faults. In
this design it would propagate fault data to user space(QEMU) through VFIO. 
vIOMMU emulator then emulate the fault. Either fill data to vIOMMU fault
record registers or fill the data to memory-resident fault log region. Depends
on the fault reporting type.(primary fault logging or advanced fault logging)

g) SVM Virtualization Architecture
**********************************************************************
 Guest                                 +------------------+           
                                    +->|   vIOMMU driver  |           
                                    |  +------+---------+-+           
                                    |         |         |             
                                    +----+(1) |(2)      |(3)          
                                         |    |         |             
*****************************************|****|*********|*************
 Host User                               |    v         v             
 Space                                +--+---------------------+      
                                      |       Qemu vIOMMU      |      
                                      +--+----+----+----+----+-+      
                                         |    |    |    |    |        
*****************************************|****|****|****|****|********
 Host Kernel                             |(1) |(2) |(4) |(5) |(6)     
 Space                                   |    |    |    |    |        
     +-----------------------+       +---+----+----+----+----+---+    
     |      IOMMU Fault      |       |   |    |    |    |    |   |    
     |  +--------------------+-------+---+    |    |    |    |   |    
     |  |                    |       |        |    |    |    |   |    
     |  |  +-----------------+-------+--------+    |    |    |   |    
     |  |  |                 |       |             |    |    |   |    
     |  |  |    IOMMU        |       |        VFIO |    |    |   |    
     |  |  |    Driver       |       |             |    |    |   |    
     |  |  |        +--------+-------+-------------+    |    |   |    
     |  |  |        |        |       |                  |    |   |    
     |  |  |        |  +-----+-------+------------------+    |   |    
     |  |  |        |  |     |       |                       |   |    
     |  |  |        |  |  +--+-------|-----------------------+   |    
     |  |  |        |  |  |  |       |                           |    
     +--+--+--------+--+--+--+       +---------------------------+    
        |  |        |  |  |                                           
********|**|********|**|**|*******************************************
 HW     |  |        |  |  |                                           
        |  v        v  v  v                                           
      +-+--------------------+                                        
      |       pIOMMU         |                                        
      +----------------------+                                        
                                                                      
**********************************************************************
(1)Fault reporting, include recoverable and un-recoverable faults
(2)PRQ response
(3)Translation cache invalidation(QI)
(4)Set nested mode in pIOMMU ex-context entry
(5)Shadow gPASID table pointer to pIOMMU ex-context entry
(6)Cache invalidation for 1st level translation
<if the diagram is disordered, you may want to paste it to a Linux email client>

4. How to test
Test would be done with devices which has SVM capability. Hereby, Intel i915
GPU would be chosen to do the verification. Intel provides three tools from for
SVM verification. They are:
i) 	intel-gpu-tools/tests/gem_svm_sanity
ii)	intel-gpu-tools/tests/gem_svm_fault
iii)	intel-gpu-tools/tests/gem_svm_storedw_loop_render

The following scenarios would have to be covered:

a) Test case 1 - SVM usage in host
i)	Requires a physical machine which has at least one SVM capable device. 
ii)	Run Test Tools in host. 
iii)	Expect: with vSVM enabled, it shouldn't affect SVM usage in host

b) Test case 2 - SVM usage in guest
i)	Requires a physical machine which has at least one SVM capable device. 
ii)	Create a guest, and assign a SVM capable device to it. 
iii)	Run Test Tools in the guest.
iV)	Expect: with vSVM enabled and device assigned, guest should be able to
use SVM with the assigned device

c) Test case 3 - SVM usage in multi-guests scenario
i)	Requires a physical machine which has at least two SVM capable devices. 
ii)	Create two guests, and assign a SVM capable device to each of them. 
iii)	Run Test Tools on both of the two guests.
iV)	Expect: multi-guest should be able to use SVM with its assigned
devices without affect each other

d) Test case 4 - SVM usage in host/guest scenario 
i)	Requires a physical machine which has at least two SVM capable devices. 
ii)	Create a guest, and assign a SVM capable device to the guest. 
iii)	Run Test Tools on both of the host and the guest.
iV)	Expect: host and guest shouldn't affect each other

5. Terms:
SVM: Shared Virtual Memory
CSR: Means the IOMMU registers in this slide
IOVA: IO Virtual Address
PRQ: Page Request
vIOMMU: Virtual IOMMU emulated by QEMU
FLPT: First Level Page Table
SLPT: Second Level Page Table
QI: Queued Invalidation, a mechanism used to invalidate cache in VTd
PASID: Process Address Space ID

Thanks,

Best Wishes,
Yi Liu
