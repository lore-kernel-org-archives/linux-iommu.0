From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: re: iommu/vt-d: Implement page request handling
Date: Thu, 15 Oct 2015 21:25:30 +0300
Message-ID: <20151015182530.GF3163@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello David Woodhouse,

This is a semi-automatic email about new static checker warnings.

The patch 0b9252a34858: "iommu/vt-d: Implement page request handling" 
from Oct 8, 2015, leads to the following Smatch complaint:

drivers/iommu/intel-svm.c:452 prq_event_thread()
	 error: we previously assumed 'svm' could be null (see line 412)

drivers/iommu/intel-svm.c
   411				svm = idr_find(&iommu->pasid_idr, req->pasid);
   412				if (!svm) {

The patch adds a NULL check here.

   413					pr_err("%s: Page request for invalid PASID %d: %08llx %08llx\n",
   414					       iommu->name, req->pasid, ((unsigned long long *)req)[0],
   415					       ((unsigned long long *)req)[1]);
   416					mutex_unlock(&pasid_mutex);
   417					goto inval_req;
   418				}
   419				/* Strictly speaking, we shouldn't need this. It is forbidden
   420				   to unbind the PASID while there may still be requests in
   421				   flight. But let's do it anyway. */
   422				kref_get(&svm->kref);
   423				mutex_unlock(&pasid_mutex);
   424			}
   425	
   426			result = QI_RESP_FAILURE;
   427			down_read(&svm->mm->mmap_sem);
   428			vma = find_extend_vma(svm->mm, address);
   429			if (!vma || address < vma->vm_start)
   430				goto hard_fault;
   431	
   432			ret = handle_mm_fault(svm->mm, vma, address,
   433					      req->wr_req ? FAULT_FLAG_WRITE : 0);
   434			if (ret & VM_FAULT_ERROR)
   435				goto hard_fault;
   436	
   437			result = QI_RESP_SUCCESS;
   438		hard_fault:
   439			up_read(&svm->mm->mmap_sem);
   440		inval_req:
   441			/* Accounting for major/minor faults? */
   442	
   443			if (req->lpig) {

Perhaps this check ensures that "svm" is not NULL but I don't know the
code well enough to say.

   444				/* Page Group Response */
   445				resp.low = QI_PGRP_PASID(req->pasid) |
   446					QI_PGRP_DID((req->bus << 8) | req->devfn) |
   447					QI_PGRP_PASID_P(req->pasid_present) |
   448					QI_PGRP_RESP_TYPE;
   449				resp.high = QI_PGRP_IDX(req->prg_index) |
   450					QI_PGRP_PRIV(req->private) | QI_PGRP_RESP_CODE(result);
   451	
   452				qi_submit_sync(&resp, svm->iommu);
                                                      ^^^^^^^^^^
The patch introduces a NULL dereference here.

   453			} else if (req->srr) {
   454				/* Page Stream Response */

regards,
dan carpenter
