From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] iommu/amd: fix incorrect error handling
Date: Mon, 24 Apr 2017 12:39:05 +0200
Message-ID: <20170424103905.GH7266@8bytes.org>
References: <1492943001-1078-1-git-send-email-bianpan201602@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1492943001-1078-1-git-send-email-bianpan201602-9Onoh4P/yGk@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Pan Bian <bianpan201602-9Onoh4P/yGk@public.gmane.org>
Cc: Pan Bian <bianpan2016-9Onoh4P/yGk@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Sun, Apr 23, 2017 at 06:23:21PM +0800, Pan Bian wrote:
> From: Pan Bian <bianpan2016-9Onoh4P/yGk@public.gmane.org>
> 
> In function amd_iommu_bind_pasid(), the control flow jumps to label
> out_free when pasid_state->mm and mm is NULL. And mmput(mm) is called.
> In function mmput(mm), mm is referenced without validation. This will
> result in a NULL dereference bug. This patch fixes the bug.
> 
> Signed-off-by: Pan Bian <bianpan2016-9Onoh4P/yGk@public.gmane.org>

Applied, thanks.
