From: Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: What differences and relations between SVM, HSA, HMM and Unified
	Memory?
Date: Mon, 12 Jun 2017 14:44:14 -0400
Message-ID: <20170612184413.GA5924@gmail.com>
References: <9BD73EA91F8E404F851CF3F519B14AA8CE753F@SZXEMI503-MBS.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9BD73EA91F8E404F851CF3F519B14AA8CE753F-OQh+Io27EUn0mp2XfTw+mgK1hpo4iccwjNknBlVQO8k@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Wuzongyong (Cordius Wu, Euler Dept)" <wuzongyong1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: "Wanzongshun (Vincent)" <wanzongshun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "oded.gabbay-5C7GfCeVMHo@public.gmane.org" <oded.gabbay-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, Jun 10, 2017 at 04:06:28AM +0000, Wuzongyong (Cordius Wu, Euler Dep=
t) wrote:
> Hi,
> =

> Could someone explain differences and relations between the SVM
> (Shared Virtual Memory, by Intel), HSA(Heterogeneous System
> Architecture, by AMD), HMM(Heterogeneous Memory Management, by Glisse)
> and UM(Unified Memory, by NVIDIA) ? Are these in the substitutional
> relation?
>
> As I understand it, these aim to solve the same thing, sharing
> pointers between CPU and GPU(implement with ATS/PASID/PRI/IOMMU
> support). So far, SVM and HSA can only be used by integrated gpu.
> And, Intel declare that the root ports doesn't not have the
> required TLP prefix support, resulting  that SVM can't be used
> by discrete devices. So could someone tell me the required TLP
> prefix means what specifically?
>
> With HMM, we can use allocator like malloc to manage host and
> device memory. Does this mean that there is no need to use SVM
> and HSA with HMM, or HMM is the basis of SVM and HAS to
> implement Fine-Grained system SVM defined in the opencl spec?

So aim of all technology is to share address space between a device
and CPU. Now they are 3 way to do it:

  A) all in hardware like CAPI or CCIX where device memory is cache
     coherent from CPU access point of view and system memory is also
     accessible by device in cache coherent way with CPU. So it is
     cache coherency going both way from CPU to device memory and from
     device to system memory


  B) partially in hardware ATS/PASID (which are the same technology
     behind both HSA and SVM). Here it is only single way solution
     where you have cache coherent access from device to system memory
     but not the other way around. Moreover you share the CPU page
     table with the device so you do not need to program the IOMMU.

    Here you can not use the device memory transparently. At least
    not without software help like HMM.


  C) all in software. Here device can access system memory with cache
     coherency but it does not share the same CPU page table. Each
     device have their own page table and thus you need to synchronize
     them.

HMM provides helper that address all of the 3 solutions.
  A) for all hardware solution HMM provides new helpers to help
     with migration of process memory to device memory
  B) for partial hardware solution you can mix with HMM to again
     provide helpers for migration to device memory. This assume
     you device can mix and match local device page table with
     ATS/PASID region
  C) full software solution using all the feature of HMM where it
     is all done in software and HMM is just doing the heavy lifting
     on behalf of device driver

In all of the above we are talking fine-grained system SVM as in
the OpenCL specificiation. So you can malloc() memory and use it
directly from the GPU.

Hope this clarify thing.

Cheers,
J=E9r=F4me
