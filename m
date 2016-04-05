From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu: change generic_device_group function
Date: Tue, 5 Apr 2016 17:04:08 +0200
Message-ID: <20160405150408.GF11519@8bytes.org>
References: <1458907611-19694-1-git-send-email-cn_wyl2003@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1458907611-19694-1-git-send-email-cn_wyl2003-KN7UnAbNpbg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: cn_wyl2003-KN7UnAbNpbg@public.gmane.org
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yalin.wang2010-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, nicolas.iooss_linux-oWGTIYur0i8@public.gmane.org, renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 25, 2016 at 08:06:51PM +0800, cn_wyl2003-KN7UnAbNpbg@public.gmane.org wrote:
> From: yalin wang <yalin.wang2010-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> change this function to return only iommu_group* pointer or
> PTR_ERR(), never return NULL when failed.
> The caller of this function only check IS_ERR() for its return value.
> 
> Signed-off-by: yalin wang <yalin.wang2010-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

You are right, thanks for catching this. But please leave the
generic_device_group function in iommu.c. It is assigned to a function
pointer by drivers, so inlining it doesn't make sense anyway.


	Joerg
