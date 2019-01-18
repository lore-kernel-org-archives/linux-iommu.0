From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-debug: add dumping facility via debugfs
Date: Fri, 18 Jan 2019 12:35:43 +0100
Message-ID: <20190118113543.GA9481@lst.de>
References: <1547646265-9414-1-git-send-email-clabbe@baylibre.com> <2f43688f-9c08-a9c4-6175-caa3d2e40261@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2f43688f-9c08-a9c4-6175-caa3d2e40261@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Corentin Labbe <clabbe@baylibre.com>, hch@lst.de, m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, joro@8bytes.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 16, 2019 at 06:10:13PM +0000, Robin Murphy wrote:
> It's a shame that this is pretty much a duplication of 
> debug_dma_dump_mappings(), but there seems no straightforward way to define 
> one in terms of the other :/

We could always play some macro magic, but I think that is worse than
duplicating a little bit of functionality.

Btw, the dev argument to debug_dma_dump_mappings is always NULL and
could be removed..

> (although given that we'd rather not have that weird external interface 
> anyway, maybe "now you can use debugfs instead" might be justification 
> enough for cleaning it up...)

One argument against that is the system might be in a shape where you
can't easily read a file when it is in that shape.  The argument for
that is that in many systems the full list of mappings might overwhelm
the kernel log.

Adding Joerg, who originally wrote the code in case he has an opinion.

>
>> +
>> +static int dump_open(struct inode *inode, struct file *file)
>> +{
>> +	return single_open(file, dump_read, inode->i_private);
>> +}
>> +
>> +static const struct file_operations dump_fops = {
>> +	.owner = THIS_MODULE,
>> +	.open = dump_open,
>> +	.read = seq_read,
>> +	.llseek = seq_lseek,
>> +	.release = single_release,
>> +};
>> +
>
> DEFINE_SHOW_ATTRIBUTE()?
>
> Robin.
>
>>   static int dma_debug_fs_init(void)
>>   {
>>   	dma_debug_dent = debugfs_create_dir("dma-api", NULL);
>> @@ -894,6 +936,11 @@ static int dma_debug_fs_init(void)
>>   	if (!filter_dent)
>>   		goto out_err;
>>   +	dump_dent = debugfs_create_file("dump", 0444,
>> +					dma_debug_dent, NULL, &dump_fops);
>> +	if (!dump_dent)
>> +		goto out_err;
>> +
>>   	return 0;
>>     out_err:
>>
---end quoted text---
