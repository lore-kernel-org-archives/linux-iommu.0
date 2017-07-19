From: Shaobo <shaobo-sDh8Nw2yj/+Vc3sceRu5cw@public.gmane.org>
Subject: Potentially invalid memory accesses in file
	drivers/iommu/intel-iommu.c
Date: Wed, 19 Jul 2017 17:51:54 -0600
Message-ID: <60e712de98322ef4e0730cdd2b73d8a3@cs.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi there,

My name is Shaobo He and I am a graduate student at University of Utah. 
I am using a static analysis tool to search for null pointer 
dereferences and came across a couple of potentially invalid memory 
accesses in the file drivers/iommu/intel-iommu.c. Function 
`domain_get_iommu` can return a NULL pointer. There are four uses of 
this function in the file drivers/iommu/intel-iommu.c:

1. In function `__intel_map_single:
The return value is not NULL-checked.

2. In function `add_unmap`:
The return value is not NULL-checked.

3. In function `intel_unmap`:
The return value is not NULL-checked in its callees.

4. In function `intel_map_sg`:
The return value is not NULL-checked.

So I was wondering if the NULL condition is actually infeasible 
otherwise there seems to exist NULL pointer dereferences.

Best,
Shaobo
