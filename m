From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: Feature Request: Ability to decode bus/dma address back into physical
	address
Date: Tue, 1 Aug 2017 06:07:48 -0400
Message-ID: <8379cf5a-7539-e221-c678-20f617fb4337@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

We're working on a user space debugger for AMDGPU devices and are trying 
to figure out a "proper" way of taking mapped pages and converting them 
back to physical addresses so the debugger can read memory that was sent 
to the GPU.

The debugger largely operates at arms length from the application being 
debugged so it has no knowledge of the buffers other than which PCI 
device mapped it and the mapped address.

We also use the debugger to read back kernel programmed buffers (ring 
buffers and the like) so we really need a kernel level solution.

As a prototype I put a trace point in the AMDGPU driver when 
pci_map_page() is called which preserves the physical and dma address 
and that works but obviously is a bit of a hack and doesn't work if 
pages are mapped before the trace is enabled.

Ideally, some form of debugfs interface would be nice.

Is there any sort of interface already I can take advantage of?  I've 
tried enabling the map/unmap tracepoints before loading amdgpu and it 
produced no traffic in the trace file.

Thanks,
Tom
