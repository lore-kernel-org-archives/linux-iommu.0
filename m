From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 1/2] debugfs: Allow debugfs_create_dir() to take data
Date: Wed, 8 Aug 2012 06:34:27 -0700
Message-ID: <20120808133427.GA14417@kroah.com>
References: <1344407073-12030-1-git-send-email-hdoyu@nvidia.com>
	<1344407073-12030-2-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1344407073-12030-2-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Aug 08, 2012 at 09:24:32AM +0300, Hiroshi Doyu wrote:
> Add __debugfs_create_dir(), which takes data passed from caller.

Why?

> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  fs/debugfs/inode.c      |    7 ++++---
>  include/linux/debugfs.h |    9 ++++++++-
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index 4733eab..423df9f 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -387,7 +387,7 @@ struct dentry *debugfs_create_file(const char *name, umode_t mode,
>  EXPORT_SYMBOL_GPL(debugfs_create_file);
>  
>  /**
> - * debugfs_create_dir - create a directory in the debugfs filesystem
> + * __debugfs_create_dir - create a directory in the debugfs filesystem
>   * @name: a pointer to a string containing the name of the directory to
>   *        create.
>   * @parent: a pointer to the parent dentry for this file.  This should be a
> @@ -404,10 +404,11 @@ EXPORT_SYMBOL_GPL(debugfs_create_file);
>   * If debugfs is not enabled in the kernel, the value -%ENODEV will be
>   * returned.
>   */
> -struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
> +struct dentry *__debugfs_create_dir(const char *name, struct dentry *parent,
> +				    void *data)
>  {
>  	return __create_file(name, S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,
> -				   parent, NULL, NULL);
> +				   parent, data, NULL);
>  }
>  EXPORT_SYMBOL_GPL(debugfs_create_dir);

You can't export a symbol that doesn't exist anymore.

What are you trying to do here?  This patch doesn't look right at all.

greg k-h
