From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH 4/4] iommu/vt-d: Do access checks before calling
	handle_mm_fault()
Date: Tue, 10 Nov 2015 09:43:03 -0800
Message-ID: <CA+55aFwXn2ak_zjKyVGznYwoCDewHicFYX-ngLtrofDPyQ0N=w@mail.gmail.com>
References: <1447162006-20672-1-git-send-email-joro@8bytes.org>
	<1447162006-20672-5-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1447162006-20672-5-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "open list:AMD IOMMU (AMD-VI)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 10, 2015 at 5:26 AM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> +
> +static bool access_error(struct vm_area_struct *vma, struct page_req_dsc *req)
> +{
> +       return !((req->rd_req  && (vma->vm_flags & VM_READ))  ||
> +                (req->wr_req  && (vma->vm_flags & VM_WRITE)) ||
> +                (req->exe_req && (vma->vm_flags & VM_EXEC)));
> +}

This seems odd.

Shouldn't it be

    return ((req->rd_req  && !(vma->vm_flags & VM_READ))  ||
            (req->wr_req  && !(vma->vm_flags & VM_WRITE)) ||
            (req->exe_req && !(vma->vm_flags & VM_EXEC)));

instead?

Of course, if you just used the VM_xyz flags internally itself, this
would all be easier, and you'd end up with something like

    /* Do we have requested bits that aren't in the allowed set? */
    return (requested & ~vma->vm_flags) != 0;

instead..

              Linus
