From: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Remove unnecassary qi clflushes
Date: Tue, 5 Jul 2016 18:40:47 +0200
Message-ID: <ac3ff8d4-e47b-e4d8-40ed-02811732526a@redhat.com>
References: <1466773994-242872-1-git-send-email-namit@vmware.com>
	<20160627113014.GL11432@8bytes.org>
	<C78095BC-3BED-48DE-90CE-601DE40AA613@gmail.com>
	<926A8CFB-D22D-4DC6-9EE0-D912451365BB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <926A8CFB-D22D-4DC6-9EE0-D912451365BB-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Nadav Amit <nadav.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Nadav Amit <namit-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 05/07/2016 18:27, Nadav Amit wrote:
>> Although such hardware is old, there are some hypervisors that do not set
>> the ecap.coherency of emulated IOMMUs. Yes, it is unwise, but there is no
>> reason to further punish these hypervisors.

QEMU will need the kernel to respect ecap.coherency in order to support
nested VFIO, for example.

Paolo
